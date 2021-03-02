class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for "notification:#{current_user.id}"
  end
end
