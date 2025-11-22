class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:date].present?
      @events = Event.where(date_time: params[:date].to_date.all_day)
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def register
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    return unless @event.update(event_params)

    redirect_to event_path(@event)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, status: :see_other
  end

  def conversation_starters
    @event = Event.find(params[:id])
    @starters = AiStarterService.generate_event_starters(@event, current_user) || []
    respond_to do |format|
      format.turbo_stream
      format.html { render :conversation_starters, layout: false }
      format.json { render json: { starters: @starters } }
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
        format.html { redirect_to chat_path(@event), notice: "Sent to chat!"}
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :max_capacity, :date, :time)
  end
end
