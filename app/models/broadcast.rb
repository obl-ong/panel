class Broadcast < ApplicationRecord
  def self.unexpired
    select { |b| b.expires_at > DateTime.now }
  end
end
