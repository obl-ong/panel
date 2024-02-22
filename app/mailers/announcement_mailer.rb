class AnnouncementMailer < ApplicationMailer
  default from: "announcements@obl.ong", return_path: "team@obl.ong", message_steam: "broadcast"
  def announce(user, subject, content)
    mail(to: user.email, subject: subject, body: content)    
  end
end
