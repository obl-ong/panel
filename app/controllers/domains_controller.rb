class DomainsController < ApplicationController
  helper DnsimpleHelper
  nested_layouts 'layouts/admin', 'layouts/domain', 'layouts/application', except: [:index, :request_domain]
  nested_layouts 'layouts/admin', 'layouts/application', only: [:index, :request_domain]

  def index
    if !current_user
      redirect_to controller: 'users', action: 'auth'
    else
      @domains = Domain.where(users_id: current_user)
    end
  end

  def dns
    @domain = Domain.find_by(host: params['host'])
    # records for domain which aren't system_record
    @records = helpers.client.zones.list_zone_records(
      Rails.application.credentials.dnsimple.account_id,
      params['host'] + '.' + ENV['DOMAIN']
    ).data.select { |record| !record.system_record }
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
    @domain = Domain.new(host: params[:host], users_id: current_user.id)
    if @domain.save
      redirect_to action: 'dns', host: params[:host]
    else
      render json: @domain.errors, status: 418
    end
  end

  def add_record
    @domain = Domain.find_by(host: params[:host])

    if @domain.add_record(params['name'], params['type'], params['content'], ttl: params['ttl'],
                                                                             priority: params['priority'])
      redirect_to action: 'dns', host: params[:host]
    else
      render json: @domain.errors, status: 418
    end
  end

  def destroy_record
    @domain = Domain.find_by(host: params[:host])
    if @domain.destroy_record(params['recordId'])
      redirect_to action: 'dns', host: params[:host]
    else
      render_json @domain.errors, status: 418
    end
  end
end
