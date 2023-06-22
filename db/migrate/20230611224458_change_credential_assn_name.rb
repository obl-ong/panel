class ChangeCredentialAssnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_credentials, :user_users_id, :user_id
  end
end
