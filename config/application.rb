require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdminOblOng
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_mailer.delivery_method = :postmark

    config.sentry = true

    config.action_mailer.postmark_settings = {
      api_token: Rails.application.credentials.postmark_api_token
    }

    # Change to where you're hosting Obl.ong in production
    config.webauthn_origin = "https://admin.obl.ong"
    config.webauthn_rp_id = "admin.obl.ong"

    # Change to the domain where you're registering subdomains
    config.domain = "obl.ong"

    config.assets.paths << Rails.root.join("app/javascript")

    config.slack_notify = false

    config.mission_control.jobs.base_controller_class = "AdminController"
    config.audits1984.base_controller_class = "AdminController"
    config.audits1984.auditor_class = "::User::User"
  end
end
