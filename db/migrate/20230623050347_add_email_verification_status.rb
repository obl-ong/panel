class AddEmailVerificationStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :user_users, :verified, :boolean
  end
end
