class ChangeUserCredentialAssociation < ActiveRecord::Migration[7.0]
  def change
    drop_join_table :user_users, :user_credentials
    add_belongs_to :user_credentials, :user_users, foreign_key: true
  end
end
