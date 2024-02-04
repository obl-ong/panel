module Admin
  class FeaturesController < Admin::ApplicationController
    def index
      redirect_to "/admin/engines/flipper"
    end
  end
end
