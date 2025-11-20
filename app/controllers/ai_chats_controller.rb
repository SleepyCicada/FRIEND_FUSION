class AiChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ai_chat, only: [:show, :update, :destroy]

  def show
    @ai_messages = @ai_chat.ai_messages.order(created_at: :asc)
    @ai_message = AiMessage.new
  end

  def new
  end

  def create
    @ai_chat = current_user.ai_chats.new(ai_chat_params)

    if @ai_chat.save
      render :show, status: :created
    else
      render json: { errors: @ai_chat.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ai_chat.update(ai_chat_params)
      render :show
    else
      render json: { errors: @ai_chat.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @ai_chat.destroy
    redirect_to root_path, notice: "AI Chat deleted."
  end

  private
  def set_ai_chat
    @ai_chat = current_user.ai_chats.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "AI Chat not found."
  end

  def ai_chat_params
    params.require(:ai_chat).permit(:language_target, :persona, settings: {})
  end
end
