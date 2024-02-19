class User::Credential < ApplicationRecord
  encrypts :webauthn_id, deterministic: true
  encrypts :public_key, :sign_count, :name
end
