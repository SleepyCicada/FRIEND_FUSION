class AiMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ai_chat

  def index
    @messages = @ai_chat.ai_messages.order(created_at: :asc)
    render json: @messages
  end

  def create
    @user_message = @ai_chat.ai_messages.create!(
      user: current_user,
      sender_type: :user,
      content: params[:content]
    )

    assistant_reply = AiChatService.generate_reply(
      message: @user_message.content,
      user: current_user,
      ai_chat: @ai_chat
    )

    @assistant_message = @ai_chat.ai_messages.create!(
      user_id: nil,
      sender_type: :assistant,
      content: assistant_reply
    )

    respond_to do |format|
      format.json {
        render json: {
          user_message: @user_message,
          assistant_message: @assistant_message
        }
      }
      format.turbo_stream
    end
  end

  private

  def set_ai_chat
    @ai_chat = current_user.ai_chats.find(params[:ai_chat_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "AI chat not found" }, status: 404
  end

  def ai_message_params
    params.permit(:content)
  end
end
