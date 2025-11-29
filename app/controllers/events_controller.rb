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
      @events = @events.where(date_time: params[:date].to_date.all_day)
    end

    @events = @events.order(date_time: :asc)
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
    @topics = Topic.all
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      @topics = Topic.all
      render :new, status: :unprocessable_entity
    end
def create
  combined_datetime = combine_date_time(event_params[:date], event_params[:time])
  @event = Event.new(event_params.except(:date, :time))
  @event.date_time = combined_datetime
  @event.user = current_user

  if @event.save
    # 👇 Trigger the mailer here
    EventMailer.event_created(@event, current_user).deliver_now

    redirect_to event_path(@event), notice: 'Event was successfully created. A confirmation email has been sent.'
  else
    render :new
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

    chat = @event.chat || @event.create_chat!

    Message.create!(
      chat: chat,
      user: nil,
      content: params[:starter].strip,
      ai: true
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@event), notice: "Sent to chat!" }
    end
  end

  private

  def combine_date_time(date, time)
    return nil if date.blank? || time.blank?

    Time.zone.parse("#{date} #{time}")
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :max_capacity, :date, :time, :image, :topic_id)
  end
end
