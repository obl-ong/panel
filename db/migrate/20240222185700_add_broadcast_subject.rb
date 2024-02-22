class AddBroadcastSubject < ActiveRecord::Migration[7.1]
  def change
    add_column :broadcasts, :subject, :string
  end
end
