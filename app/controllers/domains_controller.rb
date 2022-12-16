class DomainsController < ApplicationController
  helper DnsimpleHelper

  def index
   @domains = Domain.all
  end

  def dns
    @domain = Domain.find_by(host: params["id"])
    @records = helpers.client.zones.list_zone_records(
    Rails.application.credentials.dnsimple.account_id,
    params["id"] + "." + ENV["DOMAIN"]).data
  end

  def destroy
    @domain = Domain.find_by(host: params["id"])
    if @domain.destroy
    redirect_to root_url
    else
    render json: @domain.errors, status: 503
  end

  def email
    @domain = Domain.find_by(host: params["id"])
  end

  def links
    @domain = Domain.find_by(host: params["id"])
  end

  def settings
    @domain = Domain.find_by(host: params["id"])
  end

  def new
    @domain = Domain.new(host: params[:host], users_id: session[:current_user_id])
    if @domain.save
      redirect_to action: "dns", id: params[:host]
    else
      render json: @domain.errors, status: 418
    end
  end
end
