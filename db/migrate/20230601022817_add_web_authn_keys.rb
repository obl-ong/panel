class AddWebAuthnKeys < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :webauthn_id, :string
  end
end
