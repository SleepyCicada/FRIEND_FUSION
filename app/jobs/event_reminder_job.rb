class EventReminderJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return unless event # Gracefully exit if event no longer exists

    user = event.user # assuming each event belongs_to :user
    return unless user # Gracefully exit if no user

    # Example: send an email reminder
    EventMailer.reminder(user, event).deliver_now

    # Or trigger a push notification service here
    NotificationService.send_push(user, "Reminder: #{event.title} starts tomorrow!")
  rescue => e
    Rails.logger.error("EventReminderJob failed for event #{event_id}: #{e.message}")
    # Don't re-raise - let the job complete gracefully
  end
end
