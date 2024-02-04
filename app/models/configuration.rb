class Configuration < ApplicationRecord
  before_create :check_for_existing
  before_destroy :check_for_existing

  # TODO: remove load function and check in app controller & just redirect to new configuration screen

  def self.load
    config = Configuration.first

    if config.nil?
      config = Configuration.create
    end

    config
  end

  def self.setup?
    !Configuration.first.nil?
  end

  private

  def check_for_existing
    raise ActiveRecord::RecordInvalid if Configuration.count >= 1
  end
end
