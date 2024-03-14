class Developers::ApplicationsController < ApplicationController
  nested_layouts 'layouts/admin'

  before_action do
    @developers = true
  end

  before_action except: %i[index request provision create] do
    if (current_application.provisional? || current_application.owner_id != current_user.id) && !current_user.admin?
      render plain: '403 Forbidden or Provisional Domain', status: 403
    end
  end

  before_action only: [:create] do
    render plain: '403 Forbidden', status: 403 unless current_user.admin?
  end

  def index
    @user = current_user
    @applications = current_user.oauth_applications
  end

  def show
    @application = current_application
  end

  def add_scope
    @application = current_application
    begin
      @application.update!(scopes: Doorkeeper::OAuth::Scopes.from_array([@application.scopes, params[:scope]]))
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
      flash.notice = e.message
    else
      flash.notice = "Added Scope #{params[:scope]}"
    ensure
      redirect_back(fallback_location: developers_applications_path(id: params[:id]))
    end
  end

  def destroy_scope
    @application = current_application
    scopes = @application.scopes.to_a
    scopes.delete(params[:scope])
    @application.update!(scopes: Doorkeeper::OAuth::Scopes.from_array(scopes))
    redirect_back(fallback_location: developers_applications_path(id: params[:id]),
                  notice: "Destroyed scope #{params[:scope]}")
  end

  def add_redirect_uri
    uri = URI.parse(params[:redirect_uri])
    if uri.scheme != 'https'
      redirect_back(fallback_location: developers_applications_path, notice: 'URIs must use HTTPS')
      return
    end
    @application = current_application
    uris = @application.redirect_uri.split("\r\n")
    uris.push(params[:redirect_uri])
    begin
      @application.update!(redirect_uri: uris.join("\r\n"))
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
      flash.notice = e.message
    else
      flash.notice = 'Added Redirect URI'
    ensure
      redirect_back(fallback_location: developers_applications_path(id: params[:id]))
    end
  end

  def destroy_redirect_uri
    @application = current_application
    uris = @application.redirect_uri.split("\r\n")
    uris.delete(params[:redirect_uri])
    @application.update!(redirect_uri: uris.join("\r\n"))
    redirect_back(fallback_location: developers_applications_path(id: params[:id]), notice: 'Destroyed Redirect URI')
  end

  def update
    @application = current_application
    @application.update!(name: params[:name]) if params[:name]
    @application.update!(confidential: params[:confidential].to_i.zero?) if params[:confidential]
    redirect_back(fallback_location: developers_applications_path(id: params[:id]), notice: 'Updated application')
  end

  def destroy
    current_application.destroy!
    redirect_to developers_path
  end

  def create
    @application = Doorkeeper::Application.new(name: params[:name], redirect_uri: params[:redirect_uri],
                                               confidential: true)
    @application.owner = current_user
    @application.save!
    redirect_to developers_application_path(id: @application.id)
  end

  def provision
    uri = URI.parse(params[:redirect_uri])
    if uri.scheme != 'https'
      redirect_back(fallback_location: developers_applications_path, notice: 'URIs must use HTTPS')
      return
    end

    @application = Doorkeeper::Application.new(name: params[:name], redirect_uri: params[:redirect_uri],
                                               plan: params[:plan], confidential: true, provisional: true)
    @application.owner = current_user
    @application.save!
    redirect_to developers_path

    Admin::NotifyJob.perform_later("
    {
      \"blocks\": [
        {
          \"type\": \"section\",
          \"text\": {
            \"type\": \"mrkdwn\",
            \"text\": \"*Application request: #{@application.name}*\"
          }
        },
        {
          \"type\": \"divider\"
        },
        {
          \"type\": \"section\",
          \"text\": {
            \"type\": \"mrkdwn\",
            \"text\": \"*User*: #{@application.owner.name} (id: #{@application.owner.id})\n\n*Plan*: #{@application.plan}\"
          },
          \"accessory\": {
            \"type\": \"button\",
            \"text\": {
              \"type\": \"plain_text\",
              \"text\": \"Review Developer Apps\",
              \"emoji\": true
            },
            \"value\": \"click_me_123\",
            \"url\": \"https://admin.obl.ong/admin/developers/review\",
            \"action_id\": \"button-action\"
          }
        }
      ]
    }")
  end

  private

  def current_application
    Doorkeeper::Application.find_by(id: params[:id])
  end
end
