class Domain::Resource < ApplicationRecord
  self.table_name = "domain_resources"
  belongs_to :domains

  def self.types
    subclasses.map { |r| r.name.demodulize }
  end
end
