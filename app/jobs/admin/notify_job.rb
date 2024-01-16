class Admin::NotifyJob < ApplicationJob
  queue_as :default

  def perform(slack_blocks)
    if Rails.application.config.slack_notify == true
      HTTParty.post(Rails.application.credentials.slack_notify, body: slack_blocks, headers: {"Content-Type" => "application/json"})
    end
  end
end
