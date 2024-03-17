if Rails.application.config.sentry == true
  Sentry.init do |config|
    config.dsn = Rails.application.credentials.sentry
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0

    config.profiles_sample_rate = 1.0
  end
end
