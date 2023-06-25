class UserOtpToken < ActiveRecord::Migration[7.0]
  def change
    add_column :user_users, :otp_token, :string
  end
end
