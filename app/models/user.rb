class User < ApplicationRecord
  validates :user, presence: true
  validates :email, uniqueness: true
end
