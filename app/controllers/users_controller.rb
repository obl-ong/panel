class UsersController < ApplicationController

  skip_before_action :check_auth, :check_verified, only: [:create, :register, :email_verification, :verify_email]
  
  nested_layouts 'layouts/admin', only: [:settings]

  def register
  end
  
  def create
    if User::User.find_by(email: params[:email]) != nil
      if User::User.find_by(email: params[:email]).verified == false
        user = User::User.find_by(email: params[:email])
        session[:current_user_id] = user.id
        session[:new_user] = true
        
        redirect_to action: 'email_verification'
      else
        flash[:notice] =  "Looks like you already have an Obl.ong account"
        redirect_to controller: 'auth', action: 'login'
      end
    else
      @user = User::User.new(email: params[:email], name: params[:name], verified: false, webauthn_id: WebAuthn.generate_user_id, otp_counter: 0, hotp_token: ROTP::Base32.random)
      if @user.save
        
        session[:current_user_id] = @user.id
        session[:new_user] = true
      
        redirect_to action: 'email_verification'
      else
        render json: @user.errors, status: 503
      end
    end
  
  end

  def email_verification
    user = current_user
    @user = user
    if Time.now.to_i > (user.try(:otp_last_minted).nil? ? 0 : user.otp_last_minted) + 600 || params[:resend] == "true" then
      User::Mailer.with(user: user).verification_email.deliver_later
      if params[:resend] == "true" then flash[:notice] = "Sent email code" end
    end
  end

  def verify_email
    u = current_user
    if u.use_otp(params[:code]) == true then
      session[:email_verified] = true
      if params[:skip_passkey] == 'true'
        u.update(verified: true)
        session[:authenticated] = true
        redirect_to controller: 'domains', action: 'index'
      else
        redirect_to controller: 'auth', action: 'create_key'
      end
    else
      render inline: "<%= turbo_stream.replace \"error\" do %><p class=\"error\">Invalid OTP</p><% end %>", status: :unprocessable_entity, format: :turbo_stream
    end
  end

  def settings
    @user = self.current_user

    @credentials = User::Credential.where(user_users_id: @user.id)
  end

  def update
    @user = self.current_user

    @user.name = params[:name]
    @user.email = params[:email]

    if @user.email_changed?
      @user.verified = false
    end

    @user.save

    redirect_to(controller: "users", action: "settings")

  end

end
