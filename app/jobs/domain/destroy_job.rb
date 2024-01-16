class Domain::DestroyJob < ApplicationJob
  queue_as :default

  def perform(host)
    Record.destroy_all_host!(host)
  end
end
