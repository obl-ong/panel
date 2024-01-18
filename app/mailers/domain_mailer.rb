class DomainMailer < ApplicationMailer
  default from: "team@obl.ong"

  def domain_created_email
    @domain = params[:domain]
    mail(to: params[:email], subject: "Your domain has been created!", message_stream: "outbound")
  end
end
