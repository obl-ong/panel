class Domain::InitializeJob < ApplicationJob
  queue_as :default

  def perform(domain_id)
    domain = Domain.find_by(id: domain_id)
    Record.create(domain_id: domain_id, name: nil, type: "URL", content: "https://parking.obl.ong", ttl: 300, priority: 0) # standard:disable all
    DomainMailer.with(email: User::User.find_by(id: domain.user_users_id).email, domain: domain.host).domain_created_email.deliver_later
  end
end
