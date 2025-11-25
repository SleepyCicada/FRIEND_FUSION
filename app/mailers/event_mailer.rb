class EventMailer < ApplicationMailer
  def reminder(user, event)
    @event = event
    mail(to: user.email, subject: "Reminder: #{event.title} starts tomorrow")
  end
end
