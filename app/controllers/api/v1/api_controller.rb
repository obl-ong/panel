class Api::V1::ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :not_provisional

  private

  # Find the user that owns the access token
  def current_user
    User::User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def not_provisional
    if Doorkeeper::Application.find_by(id: doorkeeper_token.application_id).provisional?
      render plain: "425 Too Early - Provisional Client", status: 425
    end
  end
end
