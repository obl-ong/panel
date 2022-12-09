class InitInfoNameAndDomain < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :domains, :host, :string
    add_belongs_to :domains, :users, foreign_key: true
  end
end
