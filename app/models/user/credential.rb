class User::Credential < ApplicationRecord
  encrypts :name
end
