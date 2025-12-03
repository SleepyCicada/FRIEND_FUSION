class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @events = Event.all

    # Filter by topic if topic_id is present in params
    if params[:topic_id].present?
      @topic = Topic.find(params[:topic_id])
      @events = @events.where(topic_id: params[:topic_id])
    end

    # Filter by date if present
    if params[:date].present?
      begin
        date = Date.parse(params[:date])
        @events = @events.where(date_time: date.all_day)
      rescue ArgumentError, TypeError
        # Ignore invalid date format - just don't filter by date
        Rails.logger.warn("Invalid date format: #{params[:date]}")
      end
    end

    # Separate upcoming and past events using database queries for better performance
    current_time = Time.current
    @upcoming_events = @events.where("end_time IS NULL OR end_time >= ?", current_time).order(date_time: :asc)
    @past_events = @events.where("end_time < ?", current_time).order(date_time: :asc)
  end

  def my_events
    @events = current_user.events.order(date_time: :asc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def register
  end

  def new
    @event = Event.new
    # Pre-select topic if coming from a topic-specific page
    if params[:topic_id].present?
      @event.topic_id = params[:topic_id]
      @topic = Topic.find(params[:topic_id])
      @topics = [@topic] # Only show the selected topic
    else
      @topics = Topic.all
    end
  end

  def create
    # Adjust datetime params for timezone BEFORE Rails parses them
    adjust_params_for_timezone

    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      # 👇 Trigger the mailer here
      EventMailer.event_created(@event, current_user).deliver_now

      redirect_to event_path(@event), notice: 'Event was successfully created. A confirmation email has been sent.'
    else
      # Restore topics for the form
      if params[:event][:topic_id].present?
        @topic = Topic.find_by(id: params[:event][:topic_id])
        @topics = @topic ? [@topic] : Topic.all
      else
        @topics = Topic.all
      end
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
    @topics = Topic.all
  end

  def update
    @event = Event.find(params[:id])
    authorize @event

    # Adjust datetime params for timezone BEFORE Rails parses them
    adjust_params_for_timezone

    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to events_path, status: :see_other, notice: "Event deleted successfully."
  end

  def conversation_starters
    @event = Event.find(params[:id])
    @starters = AiStarterService.generate_event_starters(@event, current_user) || []
    respond_to do |format|
      format.turbo_stream
      format.html { render :conversation_starters, layout: false }
      format.json { render json: { starters: @starters } }
    end
  end

  def send_starter
    @event = Event.find(params[:id])

    # Authorization: Only event organizer or confirmed attendees can send starters
    unless @event.user == current_user || @event.confirmations.exists?(user: current_user)
      redirect_to root_path, alert: "You don't have access to this event's chat."
      return
    end

    # Validate starter content
    starter_content = params[:starter]&.strip
    if starter_content.blank?
      redirect_to event_path(@event), alert: "Starter message cannot be empty."
      return
    end

    if starter_content.length > 500
      redirect_to event_path(@event), alert: "Starter message is too long (max 500 characters)."
      return
    end

    chat = @event.chat || @event.create_chat!

    Message.create!(
      chat: chat,
      user: nil,
      content: starter_content,
      ai: true
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@event), notice: "Sent to chat!" }
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :max_capacity, :date_time, :end_time, :image,
                                  :topic_id)
  end

  def adjust_params_for_timezone
    # If timezone_offset is provided from the browser, adjust the datetime params
    # timezone_offset is in minutes (e.g., +300 for EST which is UTC-5, +480 for PST which is UTC-8)
    # getTimezoneOffset() returns positive values for timezones west of UTC
    return unless params[:timezone_offset].present? && params[:event].present?

    offset_minutes = params[:timezone_offset].to_i
    Rails.logger.info("=== Timezone adjustment ===")
    Rails.logger.info("Timezone offset: #{offset_minutes} minutes")
    Rails.logger.info("Original date_time: #{params[:event][:date_time]}")
    Rails.logger.info("Original end_time: #{params[:event][:end_time]}")

    # Convert params to a mutable hash to modify it
    event_params_hash = params[:event].to_unsafe_h

    # Adjust date_time if present
    if event_params_hash[:date_time].present?
      begin
        # Parse the datetime-local string (format: "2025-12-02T14:00")
        local_time = Time.parse(event_params_hash[:date_time])
        # Convert from local time to UTC by adding the offset
        # Example: User in EST (UTC-5) selects 2PM (14:00), offset is +300
        # 14:00 + 300 minutes = 14:00 + 5 hours = 19:00 UTC ✓
        utc_time = local_time + offset_minutes.minutes
        # Update the param with ISO8601 format that Rails will parse correctly
        event_params_hash[:date_time] = utc_time.iso8601
        Rails.logger.info("Adjusted date_time: #{event_params_hash[:date_time]}")
      rescue ArgumentError => e
        Rails.logger.error("Failed to parse date_time: #{e.message}")
      end
    end

    # Adjust end_time if present
    if event_params_hash[:end_time].present?
      begin
        local_time = Time.parse(event_params_hash[:end_time])
        utc_time = local_time + offset_minutes.minutes
        event_params_hash[:end_time] = utc_time.iso8601
        Rails.logger.info("Adjusted end_time: #{event_params_hash[:end_time]}")
      rescue ArgumentError => e
        Rails.logger.error("Failed to parse end_time: #{e.message}")
      end
    end

    # Update params with the modified values
    params[:event] = ActionController::Parameters.new(event_params_hash).permit!
  end
end
