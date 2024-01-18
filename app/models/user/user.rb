class User::User < ApplicationRecord
  validates :email, uniqueness: true # standard:disable all
  has_many :user_credentials # standard:disable all

  has_many :access_grants,
            class_name: 'Doorkeeper::AccessGrant',
            foreign_key: :resource_owner_id,
            dependent: :delete_all

  has_many :access_tokens,
            class_name: 'Doorkeeper::AccessToken',
            foreign_key: :resource_owner_id,
            dependent: :delete_all
            
  after_initialize do
    @hotp = ROTP::HOTP.new(hotp_token)
  end

  def mint_otp
    self.otp_counter += 1
    otp = @hotp.at(self.otp_counter)
    self.otp_last_minted = Time.now.to_i
    save!

    otp
  end

  def use_otp(token)
    if !begin
      @hotp.verify(token.to_s, self.otp_counter.to_i)
    rescue
      nil
    end.nil? &&
        Time.now.to_i <= otp_last_minted + 600

      self.otp_last_minted = nil
      self.otp_counter += 1
      true

    else

      false
    end
  end
end
