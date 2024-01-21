class ApplicationController < ActionController::Base
  before_action :check_auth, :check_verified

  def current_user
    @_current_user ||= session[:current_user_id] &&
      User::User.find_by(id: session[:current_user_id])
  end

  private

  def check_auth
    if session[:authenticated] != true
      redirect_to controller: "/auth", action: "login"
    end
  end

  def check_verified
    if !session[:authenticated]
      check_auth
    elsif !current_user.verified?
      redirect_to controller: "/users", action: "email_verification", params: {skip_passkey: true}
    end
  end
end
