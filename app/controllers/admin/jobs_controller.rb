module Admin
  class JobsController < Admin::ApplicationController
    def index
      redirect_to "/admin/engines/mission_control"
    end
  end
end
