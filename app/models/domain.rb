include DnsimpleHelper

class Domain < ApplicationRecord
  validates :host, uniqueness: true
  validates :users_id, presence: { message: "User ID is not present" }

  after_create_commit do
   client.domains.create_domain(Rails.application.credentials.dnsimple.account_id, name: host + "." + ENV["DOMAIN"])
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns1.dnsimple.com")
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns2.dnsimple.com")
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns3.dnsimple.com")
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns4.dnsimple-edge.org")
  end

  after_destroy_commit do
    client.domains.delete_domain(Rails.application.credentials.dnsimple.account_id, host + "." + ENV["DOMAIN"])
    for record in client.zones.all_zone_records(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], filter: { name: host }).data
      client.zones.delete_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], record.id)
    end
  end

  def add_record(name, type, content, ttl: 300, priority: 0)
    client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, host + "." + ENV["DOMAIN"], name: name, type: type, content: content, ttl: ttl.blank? ? 300 : ttl, priority: priority.blank? ? 0 : priority)
  end

  def destroy_record(recordId)
    client.zones.delete_zone_record(Rails.application.credentials.dnsimple.account_id, host + "." + ENV["DOMAIN"], recordId)
  end

  def list_records
    client.zones.all_zone_records(Rails.application.credentials.dnsimple.account_id, host + "." + ENV["DOMAIN"])
  end

  def update_record(id, **args)
    client.zones.update_zone_record(Rails.application.credentials.dnsimple.account_id, host + "." + ENV["DOMAIN"], id, **args)
  end
end
