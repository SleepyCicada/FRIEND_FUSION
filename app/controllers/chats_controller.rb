class ChatsController < ApplicationController
  before_action :set_chat
  before_action :authorize_chat_access

  def show
    @messages = @chat.messages.order(:created_at)
  end

  def summary
    @messages = @chat.messages

    @summary = AiSummaryService.generate_chat_summary(@messages, @chat.event)

    respond_to do |format|
      format.turbo_stream
      format.json { render json: { summary: @summary } }
    end
  end

  def ask_ai
    question = params[:question]

    @response = AiChatService.generate_kai_response(
      question: question,
      event: @chat.event,
      chat: @chat
    )

    respond_to do |format|
      format.turbo_stream
      format.json { render json: { response: @response } }
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def authorize_chat_access
    event = @chat.event
    # Allow access if user is the event organizer or has confirmed attendance
    unless event.user == current_user || event.confirmations.exists?(user: current_user)
      redirect_to root_path, alert: "You don't have access to this chat."
    end
  end
end
