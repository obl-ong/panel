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
end
