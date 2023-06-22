class User::User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :credentials, dependent: destroy
  
end