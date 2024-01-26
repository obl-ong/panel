class Api::V1::DomainsController < Api::V1::ApiController
  include DomainAuthorization
  before_action do
    doorkeeper_authorize! :domains
  end

  before_action only: [:create, :destroy] do
    doorkeeper_authorize! :domains_write
  end

  skip_before_action :authorize_domain, only: [:index, :create]

  def index
    @domains = Domain.where(user_users_id: current_user.id)
    if params[:records]
      doorkeeper_authorize!(:domains_records)
    end
  end

  def show
    @domain = Domain.find_by(host: params[:host])
    if params[:records]
      doorkeeper_authorize!(:domains_records)
    end
  end

  def create
    @domain = Domain.new(host: params[:host], plan: params[:plan], provisional: true, user_users_id: current_user.id)
    if @domain.save
      render "show"
    else
      render json: @domain.errors, status: 418
    end
  end

  def destroy
    @domain = Domain.find_by(host: params[:host])
    @domain.destroy!

    index
    render "index"
  end
end
