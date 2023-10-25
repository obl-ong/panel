class User::User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :user_credentials


  after_initialize do
    @hotp = ROTP::HOTP.new(self.hotp_token)
  end

  def mint_otp
    otp = @hotp.at(self.otp_counter)
    self.otp_last_minted = Time.now.to_i
    self.save
    
    otp
  end 

  def use_otp(token)
    if @hotp.verify(token.to_s, self.otp_counter.to_i) != nil && 
      Time.now.to_i <= self.otp_last_minted + 600 then

      self.otp_last_minted = nil
      self.otp_counter += 1
      true

    else

      false
    end
  end 
  
end