include DnsimpleHelper #standard:disable all  

class Record
  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::API
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Turbo::Broadcastable

  attr_accessor :name, :domain_id, :type, :ttl, :priority, :content

  define_attribute_methods :name, :domain_id, :type, :ttl, :priority, :content

  attr_writer :_persisted, :_id

  validates :name, :type, :content, :domain_id, presence: true

  validates_each :domain_id, strict: true do |record, attr, value|
    record.errors.add(attr, "Cannot create record for a provisional domain") if Domain.find_by(id: value).provisional == true
  end

  # TODO: more validation

  def initialize(attributes = {})
    super
    if name.blank?
      self.name = "@"
    end

    if ttl.blank?
      self.ttl = 300
    end
  end

  def self.create(attributes = {})
    obj = new(attributes)
    obj.validate!
    obj.save # standard:disable all

    obj
  end

  def self.filter_dnsimple_host(host, domains)
    domain = Domain.find_by(host: host)
    Rails.cache.fetch([domain, "records"], expires_in: 1.week) do
      records = []
      domains.each do |r|
        if r.domain_id == domain.id
          records.push(r)
        end
      end

      records
    end
  end

  def self.where_host(host)
    filter_dnsimple_host(host, all)
  end

  def self.dnsimple_to_record(obj)
    re = /^((.*)\.)?(.*)$/
    cap = re.match(obj.name)
    subdomain = cap[2]
    domain = cap[3]
    domain_obj = Domain.find_by(host: domain)

    Record.new(
      _id: obj.id,
      _persisted: true,
      name: subdomain,
      content: obj.content,
      priority: obj.priority,
      ttl: obj.ttl,
      type: obj.type,
      domain_id: domain_obj&.id
    )
  end

  def save
    validate!

    if persisted?
      update_record
      broadcast_replace_to(domain, partial: "records/record")
    else
      persist
      broadcast_append_to(domain, partial: "records/record")
    end

    changes_applied

    Rails.cache.delete("records")
    domain.update!(updated_at: Time.now) # standard:disable all
  end

  def update(attributes = {})
    assign_attributes(attributes)
    save # standard:disable all
  end

  def persisted?
    @_persisted
  end

  def id
    @_id
  end

  def destroy!
    destroy_record
    broadcast_remove_to(domain)
  end

  def self.destroy_all_host!(host)
    where_host(host).each do |r|
      r.destroy!
    end
  end

# TODO: cache, so not on each page load we hit DNSimple unless they don't care :P

# standard:disable all
  def self.all
    Rails.cache.fetch "records", expires_in: 2.minutes do
      dnsimple_records = client.zones.all_zone_records(Rails.application.credentials.dnsimple.account_id, Rails.application.config.domain).data.select { |record| !record.system_record }

      records = []
      for r in dnsimple_records
        if !r.name.blank?
          record = dnsimple_to_record(r)

          if record.domain_id
            records.push(record)
          end
        end
      end

      records

    end
  end

  def self.find(id)
    id = id.to_i
    found = nil
    for r in all
      if r.id == id
        found = r
        break
      end
    end

    found
  end

  # Dirtying methods

  def name=(value)
    if @name != value
      name_will_change!
      @name = value
    end
  end

  def domain_id=(value)
    if @domain_id != value
      domain_id_will_change!
      @domain_id = value
    end
  end

  def type=(value)
    if @type != value
      type_will_change!
      @type = value
    end
  end

  def ttl=(value)
    if @ttl != value
      ttl_will_change!
      @ttl = value
    end
  end

  def priority=(value)
    if @priority != value
      priority_will_change!
      @priority = value
    end
  end

  def content=(value)
    if @content != value
      content_will_change!
      @content = value
    end
  end
  # standard:disable all

  private

  def domain
    Domain.find(domain_id)
  end

  def persist
    if @name == "@" || @name == "" || @name.nil?

      record = client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, Rails.application.config.domain, name: Domain.find(domain_id).host, type: type, content: content, ttl: ttl, priority: priority)
      @_id = record.data.id

      ttl = record.data.ttl
      priority = record.data.priority
    else
      if name.ends_with?(".@")
        name.slice!(".@")
      end

      name.gsub!("@", Domain.find(domain_id).host)

      record = client.zones.create_zone_record(Rails.application.credentials.dnsimple.account_id, Rails.application.config.domain, name: name + "." + Domain.find(domain_id).host, type: type, content: content, ttl: ttl, priority: priority)

      @_id = record.data.id

      ttl = record.data.ttl
      priority = record.data.priority
    end

    @_persisted = true

    Rails.cache.delete("records")
  end

  def update_record
    if name == "@" || name == "" || name.nil?
      record = client.zones.update_zone_record(Rails.application.credentials.dnsimple.account_id, Rails.application.config.domain, id, name: Domain.find(domain_id).host, type: type, content: content, ttl: ttl, priority: priority)
      @_id = record.data.id

      ttl = record.data.ttl
      priority = record.data.priority
    else
      if name.ends_with?(".@")
        name.slice!(".@")
      end

      name.gsub!("@", Domain.find(domain_id).host)

      record = client.zones.update_zone_record(Rails.application.credentials.dnsimple.account_id, Rails.application.config.domain, id, name: name + "." + Domain.find(domain_id).host, type: type, content: content, ttl: ttl, priority: priority)
      @_id = record.data.id

      ttl = record.data.ttl
      priority = record.data.priority
    end

    domain.update(updated_at: Time.now)
    Rails.cache.delete("records")
  end

  def destroy_record
    domain.update(updated_at: Time.now)
    Rails.cache.delete("records")
    client.zones.delete_zone_record(Rails.application.credentials.dnsimple.account_id, Rails.application.config.domain, id)
    @_persisted = false
    true
  end
  
end
