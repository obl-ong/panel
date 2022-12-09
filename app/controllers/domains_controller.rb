require "dnsimple"

class DomainsController < ApplicationController

  $client = Dnsimple::Client.new(
    base_url: "https://api.sandbox.dnsimple.com",
    access_token: Rails.application.credentials.dnsimple.token
  )

  def index
   @domains = Domain.all
  end

  def dns
    @domain = Domain.find_by(host: params["id"])
    @records = $client.zones.list_zone_records(
    Rails.application.credentials.dnsimple.account_id,
    params["id"] + ".test.obl.ong").data
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
