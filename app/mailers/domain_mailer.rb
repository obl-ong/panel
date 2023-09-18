class DomainMailer < ApplicationMailer
  default from: 'team@obl.ong'

  def domain_created_email
    @user = params[:user]
    @domain = params[:domain]
    mail(to: user.email, subject: "Your domain has been created!", message_stream: 'outbound')
  end
end
