class CreateUserCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :user_credentials do |t|
      t.string :webauthn_id
      t.string :public_key
      t.integer :sign_count

      t.timestamps
    end
  end
end
