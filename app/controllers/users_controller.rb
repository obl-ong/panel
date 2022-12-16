class UsersController < ApplicationController
  def auth
  end

  def login
    if user = User.find_by(id: params[:id])
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end

  def logout
    session.delete(:current_user_id)
    @_current_user = nil
    redirect_to root_url
  end
  
  def new
    @user = User.new(email: params[:email])
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_url
    else
      render json: @user.errors, status: 503
    end
  
  end
end
