class ApplicationController < ActionController::Base
  
  before_action :check_auth
  
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User::User.find_by(id: session[:current_user_id])
  end
  

  private
  
  def check_auth
    if controller_name != "auth" && action_name != "register" && !(action_name == "create" && controller_name == "users") && !(action_name == "email_verification" && controller_name == "users") && !(action_name == "verify_email" && controller_name == "users")
      if session[:authenticated] != true
        redirect_to controller: 'auth', action: 'login'
      end
    end
  end


end
