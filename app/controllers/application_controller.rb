class ApplicationController < ActionController::Base
  before_action :ensure_configuration

  def ensure_configuration
    ::Configuration.load

    if !::Configuration.setup?
      redirect_to new_configuration_url
    end
  end
end
