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
  end

end
