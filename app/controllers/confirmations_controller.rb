class ConfirmationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    # Check if user already confirmed for this event
    if @event.confirmations.exists?(user: current_user)
      redirect_to @event, alert: "You're already registered for this event."
      return
    end

    # Check if event is at capacity
    if @event.max_capacity && @event.confirmations.count >= @event.max_capacity
      redirect_to @event, alert: "Sorry, this event is at full capacity."
      return
    end

    @confirmation = @event.confirmations.build(user: current_user)

    if @confirmation.save
      @attendees_count = calculate_attendees_count
      broadcast_new_attendee

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @event, notice: "You've successfully joined this event!" }
      end
    else
      redirect_to @event, alert: "Unable to join event. Please try again."
    end
  end

  def destroy
    @confirmation = @event.confirmations.find_by(user: current_user)

    if @confirmation.nil?
      redirect_to @event, alert: "You're not registered for this event."
      return
    end

    if @confirmation.destroy
      @attendees_count = calculate_attendees_count
      broadcast_remove_attendee

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @event, notice: "You've left this event." }
      end
    else
      redirect_to @event, alert: "Unable to leave event. Please try again."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "Event not found."
  end

  def calculate_attendees_count
    total = @event.confirmations.count
    total += 1 if @event.user.present? && !@event.users.include?(@event.user)
    total
  end

  def broadcast_new_attendee
    Turbo::StreamsChannel.broadcast_append_to(
      @event,
      target: "event-attendees",
      partial: "events/attendee_badge",
      locals: { user: current_user, event: @event }
    )

    Turbo::StreamsChannel.broadcast_update_to(
      @event,
      target: "attendees-count",
      html: @attendees_count.to_s
    )
  end

  def broadcast_remove_attendee
    Turbo::StreamsChannel.broadcast_remove_to(
      @event,
      target: "attendee-badge-#{current_user.id}"
    )

    Turbo::StreamsChannel.broadcast_update_to(
      @event,
      target: "attendees-count",
      html: @attendees_count.to_s
    )
  end
end
