class AddProvisonalPlanToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :oauth_applications, :provisional, :boolean, default: false
    add_column :oauth_applications, :plan, :text
  end
end
