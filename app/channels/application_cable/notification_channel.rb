module ApplicationCable
  class NotificationChannel < ActionCable::Channel::Base
    def subscribed
      stream_for current_user
    end
  end
end
