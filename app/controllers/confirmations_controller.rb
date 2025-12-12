class ConfirmationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    # Check if user already confirmed for this event
    if @event.confirmations.exists?(user: current_user)
      redirect_to @event, alert: "You're already registered for this event.", allow_other_host: true
      return
    end

    # Check if event is at capacity
    if @event.max_capacity && @event.confirmations.count >= @event.max_capacity
      redirect_to @event, alert: "Sorry, this event is at full capacity.", allow_other_host: true
      return
    end

    @confirmation = @event.confirmations.build(user: current_user)

    if @confirmation.save
      # Broadcast new attendee to all event subscribers
      broadcast_attendee_update
      redirect_to @event, notice: "You've successfully joined this event!", allow_other_host: true
    else
      redirect_to @event, alert: "Unable to join event. Please try again.", allow_other_host: true
    end
  end

  def destroy
    @confirmation = @event.confirmations.find_by(user: current_user)

    if @confirmation.nil?
      redirect_to @event, alert: "You're not registered for this event.", allow_other_host: true
      return
    end

    if @confirmation.destroy
      # Broadcast attendee update to all event subscribers
      broadcast_attendee_update
      redirect_to @event, notice: "You've left this event.", allow_other_host: true
    else
      redirect_to @event, alert: "Unable to leave event. Please try again.", allow_other_host: true
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "Event not found."
  end

  def broadcast_attendee_update
    EventChannel.broadcast_to(
      @event,
      {
        type: 'attendee_update',
        attendee_count: @event.confirmations.count
      }
    )
  end
end
