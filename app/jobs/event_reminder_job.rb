class EventReminderJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find(event_id)
    user  = event.user # assuming each event belongs_to :user

    # Example: send an email reminder
    EventMailer.reminder(user, event).deliver_now

    # Or trigger a push notification service here
    NotificationService.send_push(user, "Reminder: #{event.title} starts tomorrow!")
  end
end
