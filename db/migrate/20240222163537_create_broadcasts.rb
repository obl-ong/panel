class CreateBroadcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :broadcasts do |t|
      t.string :type
      t.text :content
      t.datetime :expires_at

      t.timestamps
    end
  end
end
