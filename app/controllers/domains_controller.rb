class DomainsController < ApplicationController
  # TODO: AUTHORIZATION
  
  
  helper DnsimpleHelper
  nested_layouts 'layouts/admin', 'layouts/domain', 'layouts/application', except: [:index, :request_domain]
  nested_layouts 'layouts/admin', 'layouts/application', only: [:index, :request_domain]

  def current_domain
    Domain.find_by(host: params['host'])
  end

  def index
    @domains = Domain.where(user_users_id: current_user.id)
    @user = current_user
  end

  def dns
    @domain = Domain.find_by(host: params['host'])
  end

  def dns_frame_records
    @domain = Domain.find_by(host: params['host'])
    @records = Record.where_host(@domain.host)

  end

  def destroy
    @domain = Domain.find_by(host: params['host'])
    if @domain.destroy
      redirect_to root_url
    else
      render json: @domain.errors, status: 418
    end
  end

  def email
    @domain = Domain.find_by(host: params['host'])
  end

  def links
    @domain = Domain.find_by(host: params['host'])
  end

  def settings
    @domain = Domain.find_by(host: params['host'])
  end

  def new
    @domain = Domain.new(host: params[:host], user_users_id: current_user.id)
    if @domain.save
      redirect_to domain_path(@domain)
    else
      render json: @domain.errors, status: 418
    end
  end

  def add_record
    @domain = Domain.find_by(host: params[:host])
    @record = @domain.add_record(params['name'], params['type'], params['content'], params['ttl'], params['priority'])

    if @record
      @record = @record.data
      broadcast_append_to("dns_records", partial: "domains/dns_record", locals: { record: @record }, target: "records")

      respond_to do |format|
        format.html { redirect_to action: 'dns', host: params[:host] }
        format.turbo_stream
      end
      
    else
      render json: @domain.errors, status: 418
    end

  rescue Dnsimple::RequestError => e
    render json: e.attribute_errors, status: 422
  end

  def destroy_record
    @domain = Domain.find_by(host: params[:host])
    @record = @domain.destroy_record(params['record_id'])
    if @record
      @deleted_id = params['record_id']
      respond_to do |format|
        format.html { redirect_to action: 'dns', host: params[:host] }
        format.turbo_stream
      end
    else
      render_json @domain.errors, status: 418
    end
  end

  def update_record
    @domain = Domain.find_by(host: params[:host])
    @record = @domain.update_record(params['recordId'], params['name'], params['type'], params['content'], ttl: params['ttl'],
      priority: params['priority'])
    if @record
      @record = @record.data
      respond_to do |format|
        format.html { redirect_to action: 'dns', host: params[:host] }
        format.turbo_stream
      end
    else
      render_json @domain.errors, status: 418
    end
  end
end
