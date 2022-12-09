class DomainsController < ApplicationController

  def index
   @domains = Domain.all
  end

  def dns
    @domain = Domain.find_by(host: params["id"])
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

end
