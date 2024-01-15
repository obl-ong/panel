class AddPlanToDomains < ActiveRecord::Migration[7.1]
  def change
    add_column :domains, :plan, :text, null: true
  end
end
