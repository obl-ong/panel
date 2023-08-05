class AddIndicesToUserCredentialJoinTable < ActiveRecord::Migration[7.0]
  def change
    change_table :user_credentials_users do |t|
      t.index :user_id
      t.index :credential_id
    end
  end
end
