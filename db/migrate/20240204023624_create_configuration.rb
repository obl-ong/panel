class CreateConfiguration < ActiveRecord::Migration[7.0]
  def change
    create_table :configuration do |t|
      t.string :app_email, default: "fionaho@example.com", null: false

      t.timestamps
    end
  end
end
