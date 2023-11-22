require 'json'

class AuthController < ApplicationController
  
  before_action :headers

  skip_before_action :check_auth, :check_verified
  
  
  def login

    # allow: User::Credential.all.map { |c| c.webauthn_id }
    options = WebAuthn::Credential.options_for_get( rp_id: WebAuthn.configuration.rp_id)
    
    session[:authentication_challenge] = options.challenge
    
    @options = options.as_json
  end

  def email
    user = User::User.find_by(email: params[:email])

    if(!user)
      redirect_to(controller: "users", action: "register")
      return
    elsif(user.disable_email_auth?)
      flash[:notice] = "Email login codes are disabled"
      redirect_to(controller: "auth", action: "login")
      return
    end


    if Time.now.to_i > (user.try(:otp_last_minted).nil? ? 0 : user.otp_last_minted) + 600 || params[:resend] == "true" then
      User::Mailer.with(user: user).verification_email.deliver_later
      if params[:resend] == "true" then flash[:notice] = "Sent email code" end

    end

  end
  
  def verify_code

    u = User::User.find_by(email: params[:email])

    if u.use_otp(params[:code]) == true
      session[:authenticated] = true
      session[:current_user_id] = u.id
        
      redirect_to(root_path, notice: if User::Credential.where(user_users_id: u.id).length == 0 then "Passkeys are more secure & convienient way to login. Head to Account Settings to add one." else "To disable insecure email code authentication, head to Account Settings." end)
    else
      render inline: "<%= turbo_stream.replace \"error\" do %><p class=\"error\">Invalid OTP</p><% end %>", status: :unprocessable_entity, format: :turbo_stream
    end
  end


  def create_key

    user = User::User.find_by(id: session[:current_user_id])

    if session[:email_verified] != true && user.verified != true
      redirect_to controller: "users", action: "email_verification" and return
    end

    if params[:skip_passkey] == 'true'
      user.verified = true
      user.save
      session[:authenticated] = true
      redirect_to(root_path, notice: "To add a passkey in the future, head to Account Settings")
    end
    

    @options = WebAuthn::Credential.options_for_create(
      user: { id: user.webauthn_id, name: user.email }
    )
    
    session[:creation_challenge] = @options.challenge
  end
  
  def add_key

    begin

      user = User::User.find_by(id: session[:current_user_id])
          
      if session[:email_verified] != true && user.verified != true
        redirect_to controller: "users", action: "email_verification" and return
      end

      webauthn_credential = WebAuthn::Credential.from_create(params)

      
      webauthn_credential.verify(session[:creation_challenge])

      credential = User::Credential.new(
        webauthn_id: webauthn_credential.id,
        public_key: webauthn_credential.public_key,
        sign_count: webauthn_credential.sign_count,
        user_users_id: session[:current_user_id],
        name: params[:name]
      )

      puts credential

      credential.save

      if session[:email_verified] && user.verified != true
        user.verified = true
        user.save
      end
          
      session[:authenticated] = true
    
      if params[:from_settings]
        flash[:notice] = "Disable insecure email code authentication"
      else
        flash[:notice] = "To disable insecure email code authentication, head to Account Settings."
      end

      render json: { authenticated: true }
    
    rescue WebAuthn::Error => e
      render json: { error: true, message: e }
    end
  end
  
  def verify_key
    webauthn_credential = WebAuthn::Credential.from_get(params)

    stored_credential = User::Credential.find_by(webauthn_id: webauthn_credential.id)
    
    if stored_credential == nil
      render json: { error: true, message: "No account found with that key"} and return
    end

    begin
      webauthn_credential.verify(
        session[:authentication_challenge],
        public_key: stored_credential.public_key,
        sign_count: stored_credential.sign_count
      )

      stored_credential.update!(sign_count: webauthn_credential.sign_count)
      
      session[:authenticated] = true
      session[:current_user_id] = stored_credential.user_users_id 

      flash[:notice] = "To disable insecure email code authentication, head to Account Settings."
        
      render json: { authenticated: true }
      
    rescue WebAuthn::SignCountVerificationError => e
      session[:authenticated] = true
      
      render json: { authenticated: true }
    
    rescue WebAuthn::Error => e
      render json: { error: true, message: "An error occurred;" }
    end
  end

  def destroy_key
    cred = User::Credential.find_by(id: params[:credential_id])
    if !(cred.user_users_id == current_user.id)
      render status: 403, plain: "403 Forbidden"
    end

    if User::Credential.where(user_users_id: current_user.id).length == 1
      flash[:notice] = "You can't remove your last credential without adding a new one"
      redirect_to(controller: "users", action: "settings")
    else
      cred.destroy
      redirect_to(controller: "users", action: "settings")

    end
  end
  
  def unsupported
  end

  def logout
    session.delete(:current_user_id)
    @_current_user = nil
    reset_session
    redirect_to root_url
  end

  def update_email_auth
    u = current_user

    u.disable_email_auth = !(ActiveModel::Type::Boolean.new.cast(params[:checked]))

    u.save
  end
  
  private
    def headers
      response.set_header("Access-Control-Allow-Credentials", "true")
    end
    
end
