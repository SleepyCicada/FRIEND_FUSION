class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])

    # Create user message
    @message = @chat.messages.create!(
      user: current_user,
      content: params[:message_text],
      ai: false
    )

    # Check if AI assistant mode is enabled
    if params[:ai_mode] == "true"
      # Generate AI response
      ai_response = AiChatService.generate_event_chat_reply(
        message: params[:message_text],
        user: current_user,
        chat: @chat,
        event: @chat.event
      )

      # Create AI message
      @ai_message = @chat.messages.create!(
        user: nil,
        content: ai_response,
        ai: true
      )
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@chat) }
    end
  end

  def smart_replies
    @chat = Chat.find(params[:chat_id])
    @recent_messages = @chat.messages.order(created_at: :desc).limit(5)

    @smart_replies = AiChatService.generate_smart_replies(
      messages: @recent_messages,
      event: @chat.event
    )

    render json: { replies: @smart_replies }
  end
end
