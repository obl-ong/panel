class Domain::UpdateProvisionalCountJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.cache.write("provisional_domains_count", Domain.where(provisional: true).count, expires_in: 12.hours)
  end
end
