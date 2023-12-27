include DnsimpleHelper

class Domain < ApplicationRecord
  validates :host, uniqueness: true
  validates :user_users_id, presence: { message: "User ID is not present" }

  after_create do
    Record.create(domain_id: id, name: nil, type: "URL", content: "https://parking.obl.ong", ttl: 300, priority: 0)
  end

  before_destroy do
    Record.destroy_all_host!(host)
  end

  def to_param
    host
  end


  def top_records
    records = []
    all_records = Record.where_host(host)

    if all_records.length > 3
      records[0] = all_records[0]
      records[1] = all_records[1]
      records[2] = all_records[2]
    else
      records = all_records
    end

    records
  end
end
