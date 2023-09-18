class DomainsController < ApplicationController
  # TODO: AUTHORIZATION

  include DomainAuthorization


  skip_before_action :authorize_domain, only: [:create, :index, :request_domain]

  before_action :require_admin
  skip_before_action :require_admin, except: [:create, :transfer]
  
  helper DnsimpleHelper
  nested_layouts 'layouts/admin', 'layouts/domain', 'layouts/application', except: [:index, :request_domain, :show]
  nested_layouts 'layouts/admin', 'layouts/application', only: [:index, :request_domain]

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

  def create
    @domain = Domain.new(host: params[:host], user_users_id: current_user.id)
    if @domain.save
      redirect_to domain_path(@domain)
    else
      render json: @domain.errors, status: 418
    end
  end

  def transfer
    @domain = Domain.find_by(host: params['host'])
    @domain.user_users_id = params['new_user_id']
    @domain.save
    DomainMailer.with(email: User::User.find_by(id: @domain.user_users_id).email, domain: @domain).domain_created_email.deliver_later
  end

  def show
    @domain = current_domain
    @records = []
    all_records = Record.where_host(@domain.host)

    if all_records.length > 3
      @records[0] = all_records[0]
      @records[1] = all_records[1]
      @records[2] = all_records[2]
    else
      @records = all_records
    end
  end

  def request_domain
  end

  private

  def current_domain
    Domain.find_by(host: params['host'])
  end

  def require_admin
    if current_user.admin? != true
      render status: 403, plain: "403 Forbidden"
    end
  end

end
