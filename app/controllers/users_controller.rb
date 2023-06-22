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
    if User::User.find_by(email: params[:email])
      redirect_to controller: 'auth', action: 'login', params: { from_register: true }
    else
      @user = User::User.new(email: params[:email], name: params[:name], webauthn_id: WebAuthn.generate_user_id)
      if @user.save
        
        session[:current_user_id] = @user.id
        session[:new_user] = true
      
        redirect_to controller: 'auth', action: 'blank_key'
      else
        render json: @user.errors, status: 503
      end
    end
  
  end
end
