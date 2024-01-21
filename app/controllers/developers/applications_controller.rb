class Developers::ApplicationsController < ApplicationController
  nested_layouts "layouts/admin", "layouts/application"

  before_action do
    @developers = true
  end

  def index
    @user = current_user
    @applications = current_user.oauth_applications
  end

  def show
    @application = Doorkeeper::Application.find_by(id: params[:id])
  end
end
