class Api::V1::ApiController < ActionController::Base

  skip_before_action :verify_authenticity_token

  private

  # Find the user that owns the access token
  def current_user
    User::User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
