include DnsimpleHelper

class Domain < ApplicationRecord
  validates :host, uniqueness: true
  validates :user_users_id, presence: { message: "User ID is not present" }

  
  before_create do
    Record.create(domain_id: id, name: nil, type: "URL", content: "https://parking.obl.ong", ttl: 300, priority: 0)
    client.domains.create_email_forward(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], from: host, to: User::User.find_by(id: user_users_id).email)
  end

  before_destroy do
    Record.destroy_all_host(host)
    
    for record in client.domains.all_email_forwards(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"]).data
      if record.from == host + "@" + ENV["DOMAIN"]
        client.domains.delete_email_forward(Rails.application.credentials.dnsimple.account_id, ENV["DOMAIN"], record.id)
      end
    end
  end

  def to_param
    host
  end
end
