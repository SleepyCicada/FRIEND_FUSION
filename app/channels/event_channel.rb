class EventChannel < ApplicationCable::Channel
  def subscribed
    event = Event.find(params[:event_id])

    # Only allow organizers and confirmed attendees
    if event.user == current_user || event.confirmations.exists?(user: current_user)
      stream_for event
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
