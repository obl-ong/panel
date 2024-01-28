class DeviceAuthorizationsController < Doorkeeper::ApplicationController
  before_action :authenticate_resource_owner!

  def index
  end

  def approve
    session[:device_grant_id] = nil
    device_grant = device_grant_model.lock.find_by(user_code: user_code)
    authorization_error_response(:invalid_user_code); return if device_grant.nil? # standard:disable Style/Semicolon
    authorization_error_response(:expired_user_code); return if device_grant.expired? # standard:disable Style/Semicolon
    session[:device_grant_id] = device_grant.id

    @client = Doorkeeper::Application.find_by(id: device_grant.application_id)
    @scopes = device_grant.scopes.split(" ")
  end

  def authorize
    device_grant_model.transaction do
      device_grant_model.lock.find_by(id: session[:device_grant_id]).update!(user_code: nil, resource_owner_id: current_resource_owner.id)

      render "success"
    end
  end

  def destroy
    device_grant_model.lock.find_by(id: session[:device_grant_id]).destroy # standard:disable Rails/SaveBang
    render plain: "The authorization request was denied"
  end

  def success
  end

  private

  def authorization_success_response
    respond_to do |format|
      notice = I18n.t(:success, scope: i18n_flash_scope(:authorize))
      format.html { redirect_to oauth_device_authorizations_index_url, notice: notice }
      format.json { head :no_content }
    end
  end

  # @param error_message_key [Symbol]
  def authorization_error_response(error_message_key)
    respond_to do |format|
      notice = I18n.t(error_message_key, scope: i18n_flash_scope(:authorize))
      format.html { redirect_to oauth_device_authorizations_index_url, notice: notice }
      format.json do
        render json: {errors: [notice]}, status: :unprocessable_entity
      end
    end
  end

  # @return [Class]
  def device_grant_model
    @device_grant_model ||= Doorkeeper::DeviceAuthorizationGrant.configuration.device_grant_model
  end

  # @return [String, nil]
  def user_code
    params[:user_code]
  end

  # @param action [Symbol]
  # @return [Array<Symbol>]
  def i18n_flash_scope(action)
    %I[doorkeeper flash device_codes #{action}]
  end
end
