class User::User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :user_credentials


  def mint_otp
    self.otp_last_minted = nil
    self.otp_counter = self.otp_counter.to_i + 1
    self.save
    
    hotp = ROTP::HOTP.new(self.hotp_token)
    otp = hotp.at(self.otp_counter)
    self.otp_last_minted = Time.now.to_i
    self.save
    
    otp
  end 

  def use_otp(token)
    hotp = ROTP::HOTP.new(self.hotp_token)
    hotp.verify(token, self.otp_counter)

    now = Time.now.to_i

    if self.otp_last_minted != nil && now <= self.otp_last_minted + 600
      self.otp_last_minted = nil
      self.save
      true
    end
  end 
  
end