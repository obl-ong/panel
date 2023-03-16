include DnsimpleHelper

class Domain < ApplicationRecord
  validates :host, uniqueness: true
  validates :users_id, presence: { message: "User ID is not present" }

  
  before_create do
   client.domains.create_domain(Rails.application.credentials.dnsimple.account_id, name: host + "." + ENV["DOMAIN"])
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns1.dnsimple.com")
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns2.dnsimple.com")
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns3.dnsimple.com")
   client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], name: host, type: "NS", content: "ns4.dnsimple-edge.org")
   client.domains.create_email_forward(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], from: host, to: User.find_by(id: users_id).email)
  end

  before_destroy do
    client.domains.delete_domain(Rails.application.credentials.dnsimple.account_id, host + "." + ENV["DOMAIN"])
    for record in client.zones.all_zone_records(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], filter: { name: host }).data
      client.zones.delete_zone_record(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], record.id)
    end
    
    for record in client.domains.all_email_forwards(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"]).data
      if record.from == host + "@" + ENV["DOMAIN"]
        client.domains.delete_email_forward(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], record.id)
      end
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

  def to_param
    host
  end
end
