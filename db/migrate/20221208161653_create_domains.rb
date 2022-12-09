class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|

      t.timestamps
    end
  end
end
