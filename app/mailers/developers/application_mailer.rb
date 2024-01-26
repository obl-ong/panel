class Developers::ApplicationMailer < ApplicationMailer
  def app_created_email
    @app = params[:app]
    mail(to: params[:email], subject: "Your app has been created!", message_stream: "outbound")
  end
end
