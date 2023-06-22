class ApplicationController < ActionController::Base
  
  before_action :check_auth
  
  private
  
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User::User.find_by(id: session[:current_user_id])
  end
  
  def check_auth
    if controller_name != "auth" && action_name != "register" && !(action_name == "create" && controller_name == "users") && session[:authenticated] != true
      redirect_to controller: 'auth', action: 'login'
    end
  end


end
