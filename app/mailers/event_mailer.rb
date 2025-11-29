class EventMailer < ApplicationMailer
  def reminder(user, event)
    @event = event
    mail(to: user.email, subject: "Reminder: #{event.title} starts tomorrow")
  end

  # default from: 'notifications@example.com'

  def event_created(event, user)
    @event = event
    @user = user
    mail(to: @user.email, subject: "Your event \"#{@event.title}\" has been created!")
  end
end
