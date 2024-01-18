class Domain < ApplicationRecord
  include DnsimpleHelper
  validates :host, uniqueness: true
  validates :user_users_id, presence: {message: "User ID is not present"}

  after_create ->(d) { Domain::InitializeJob.perform_later(d.id) }, unless: proc { |d| d.provisional }

  after_create ->(d) { provisional_notify }, if: proc { |d| d.provisional }
  before_update ->(d) { Domain::InitializeJob.perform_later(d.id) }, if: proc { |d| d.provisional_changed?(from: true, to: false) }

  before_update ->(d) {
                  Domain::DestroyJob.perform_later(d.host)
                  provisional_notify
                }, if: proc { |d| d.provisional_changed?(from: false, to: true) }

  before_destroy ->(d) { Domain::DestroyJob.perform_later(d.host) }, unless: proc { |d| d.provisional }

  after_commit ->(d) {
    Domain::UpdateProvisionalCountJob.perform_later
  }

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

  def user
    User::User.find_by(id: user_users_id)
  end

  def provisional_notify
    Admin::NotifyJob.perform_later("
    {
      \"blocks\": [
        {
          \"type\": \"section\",
          \"text\": {
            \"type\": \"mrkdwn\",
            \"text\": \"*Domain request: #{host}*\"
          }
        },
        {
          \"type\": \"divider\"
        },
        {
          \"type\": \"section\",
          \"text\": {
            \"type\": \"mrkdwn\",
            \"text\": \"*User*: #{user.name} (id: #{user.id})\n\n*Plan*: #{plan}\"
          },
          \"accessory\": {
            \"type\": \"button\",
            \"text\": {
              \"type\": \"plain_text\",
              \"text\": \"Review Domains\",
              \"emoji\": true
            },
            \"value\": \"click_me_123\",
            \"url\": \"https://admin.obl.ong/admin/domains/review\",
            \"action_id\": \"button-action\"
          }
        }
      ]
    }")
  end
end
