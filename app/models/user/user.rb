class User::User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :user_credentials

  after_initialize do
    @hotp = ROTP::HOTP.new(hotp_token)
  end

  def mint_otp
    self.otp_counter += 1
    otp = @hotp.at(self.otp_counter)
    self.otp_last_minted = Time.now.to_i
    save

    otp
  end

  def use_otp(token)
    if begin
      @hotp.verify(token.to_s, self.otp_counter.to_i)
    rescue
      nil
    end != nil &&
        Time.now.to_i <= otp_last_minted + 600

      self.otp_last_minted = nil
      self.otp_counter += 1
      true

    else

      false
    end
  end
end
