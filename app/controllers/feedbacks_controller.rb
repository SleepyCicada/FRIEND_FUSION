class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :authorize_feedback_owner, only: [:edit, :update, :destroy]

  def index
    @feedbacks = @event.feedbacks.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    # Check if event has ended
    unless @event.event_ended?
      redirect_to @event, alert: "You can only submit feedback after the event has ended."
      return
    end

    # Check if user has already submitted feedback
    if @event.feedbacks.exists?(user: current_user)
      redirect_to event_feedbacks_path(@event), alert: "You've already submitted feedback for this event."
      return
    end

    @feedback = @event.feedbacks.build
  end

  def create
    # Check if event has ended
    unless @event.event_ended?
      redirect_to @event, alert: "You can only submit feedback after the event has ended."
      return
    end

    # Check if user has already submitted feedback
    if @event.feedbacks.exists?(user: current_user)
      redirect_to event_feedbacks_path(@event), alert: "You've already submitted feedback for this event."
      return
    end

    @feedback = @event.feedbacks.build(feedback_params)
    @feedback.user = current_user

    if @feedback.save
      redirect_to @event, notice: "Thank you for your feedback!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to @event, notice: "Feedback updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feedback.destroy
    redirect_to @event, notice: "Feedback deleted."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "Event not found."
  end

  def set_feedback
    @feedback = @event.feedbacks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to event_feedbacks_path(@event), alert: "Feedback not found."
  end

  def authorize_feedback_owner
    unless @feedback.user == current_user
      redirect_to @event, alert: "You can only edit your own feedback."
      return
    end
  end

  def feedback_params
    params.require(:feedback).permit(:rating, :comment, pictures: [])
  end
end
