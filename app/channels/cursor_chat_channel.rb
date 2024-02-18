class CursorChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from params[:id]
  end

  def receive(data)
    ActionCable.server.broadcast(params[:id], data)
  end
end
