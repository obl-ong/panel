class SwitchToHotp < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_users, :otp_token, :hotp_token
    add_column :user_users, :otp_counter, :integer
    add_column :user_users, :otp_last_minted, :integer
  end
end
