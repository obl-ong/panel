module Admin
  class ConfigurationController < Admin::ApplicationController
    def index
      redirect_to admin_configuration_path(find_resource)
    end

    def find_resource(*)
      ::Configuration.load
    end
  end
end
