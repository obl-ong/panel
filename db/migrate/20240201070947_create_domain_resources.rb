class CreateDomainResources < ActiveRecord::Migration[7.1]
  def change
    create_table :domain_resources do |t|
      t.string :type
      t.string :name
      t.string :content
      t.integer :ttl
      t.integer :priority
      t.belongs_to :domain, foreign_key: {primary_key: :name}

      t.timestamps
    end
  end
end
