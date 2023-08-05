class CreateNewUserModelAndDeleteOldUserModel < ActiveRecord::Migration[7.0]
  def change
    remove_reference :domains, :users, foreign_key: true
    drop_table :users
    
    create_table :user_users do |t|
      t.string :email
      t.string :name
      t.string :webauthn_id
      t.timestamps
    end
    
    add_belongs_to :domains, :user_users, foreign_key: true
    create_join_table :user_users, :user_credentials
    
  end

end