class CreateDomains < ActiveRecord::Migration[7.1]
  def change
    create_table :domains, primary_key: :name, id: false do |t|
      t.string :name, null: false
      t.column :status, :integer, default: 0, null: false

      t.index :name, unique: true
      t.timestamps
    end
  end
end
