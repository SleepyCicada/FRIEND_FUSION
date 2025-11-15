class AiChatsController < ApplicationController
  def show
    @ai_chat = AiChat.find(params[:id])
    @ai_messages = @ai_chat.ai_messages.order(:created_at)
    @ai_message = AiMessage.new
  end

  def new
  end

  def create
    @ai_chat = AiChat.new(ai_chat_params)

    if @ai_chat.save
      render
    else
      render , status: :unprocessable_entity
    end
  end

  def update
    if @ai_chat.update(ai_chat_params)
      render
    else
      render , status: :unprocessable_entity
    end
  end

  def destroy
    @ai_chat.destroy
  end
end
