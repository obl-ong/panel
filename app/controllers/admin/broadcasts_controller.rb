class Admin::BroadcastsController < AdminController
  def index
    @broadcasts = { active: Broadcast.unexpired, expired: Broadcast.expired }
  end
end
