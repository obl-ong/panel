class Broadcast::Announcement < Broadcast
  after_create_commit :announce

  def announce
    User::User.find_each do |u|
      AnnouncementMailer.announce(u, subject, content).deliver_later
    end
  end
end
