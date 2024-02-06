class Domain < ApplicationRecord
  self.table_name = "domains"
  self.primary_key = "name"
  self.cache_versioning = true
  has_many :resources, class_name: "Domain::Resource"
  enum status: [:active, :disabled, :provisional]

  broadcasts_refreshes

  def soa(ns)
    Resolv::DNS::IN::SOA.new(ns, Rails.application.config.public_email, cache_version)
  end
end
