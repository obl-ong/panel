class Api::V1::Domains::RecordsController < Api::V1::ApiController
  include DomainAuthorization
  before_action do
    doorkeeper_authorize! :domains
    doorkeeper_authorize! :domains_records
  end

  before_action only: [:create, :update, :destroy] do
    doorkeeper_authorize! :domains_records_write
  end

  def index
    @records = current_domain.records
  end

  def create
    @record = Record.create(domain_id: current_domain.id, name: params["name"], type: params["type"], content: params["content"], ttl: params["ttl"], priority: params["priority"]) # standard:disable all
    render "show"
  end

  def show
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])

    (@record.type = params[:type]) if params[:type]
    (@record.name = params[:name]) if params[:name]
    (@record.content = params[:content]) if params[:content]
    (@record.ttl = params[:ttl]) if params[:ttl]
    (@record.priority = params[:priority]) if params[:priority]

    @record.save # standard:disable all

    render "show"
  end

  def destroy
    @record = Record.find(params[:id])

    @record.destroy! #standard:disable all

    index
    render "index"
  end
end
