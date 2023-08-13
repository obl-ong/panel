class AddEmailAuthOptOut < ActiveRecord::Migration[7.0]
  def change
    add_column :user_users, :disable_email_auth, :boolean
  end
end
