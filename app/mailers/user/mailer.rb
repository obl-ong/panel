class User::Mailer < ApplicationMailer
  default from: "team@obl.ong"

  def verification_email
    user = params[:user]
    @code = user.mint_otp
    mail(to: user.email, subject: @code + " is your Obl.ong email verification code", message_stream: "outbound")
  end
end
