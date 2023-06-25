class UsersController < ApplicationController


  def logout
    session.delete(:current_user_id)
    @_current_user = nil
    reset_session
    redirect_to root_url
  end
  
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
        redirect_to controller: 'auth', action: 'login', params: { from_register: true }
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
    User::Mailer.with(user: self.current_user).verification_email.deliver_later
  end

  def verify_email
    user = User::User.find_by(id: session[:current_user_id])
    if user.use_otp(params[:otp].to_s) == true
      session[:email_verified] = true
      redirect_to controller: 'auth', action: 'create_key'
    else
      render inline: "<%= turbo_stream.replace \"error\" do %><p class=\"error\">Invalid OTP</p><% end %>", status: :unprocessable_entity, format: :turbo_stream
    end
  end

end
