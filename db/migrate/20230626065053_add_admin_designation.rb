class AddAdminDesignation < ActiveRecord::Migration[7.0]
  def change
    add_column :user_users, :admin, :boolean
  end
end
