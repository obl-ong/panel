class AddNamesToCredentials < ActiveRecord::Migration[7.0]
  def change
    add_column :user_credentials, :name, :string
  end
end
