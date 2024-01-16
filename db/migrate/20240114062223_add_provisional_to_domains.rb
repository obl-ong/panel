class AddProvisionalToDomains < ActiveRecord::Migration[7.1]
  def change
    add_column :domains, :provisional, :boolean, default: false, null: false
  end
end
