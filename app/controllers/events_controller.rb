class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
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
    if @event.update(topic_params)
      redirect_to event_path
    end
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
    redirect_to topics_path, status: :see_other
  end

  def conversation_starters
    event = Event.find(params[:id])
    starters = AiStarterService.generate_event_starters(event, current_user)
    respond_to do |format|
      format.turbo_stream
      format.json { render json: { starters: @starters } }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :max_capacity, :date, :time)
  end
end
