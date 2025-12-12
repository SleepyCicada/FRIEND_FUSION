class MessagesController < ApplicationController
  before_action :set_chat
  before_action :authorize_chat_access

  def create
    # Create user message
    @message = @chat.messages.create!(
      user: current_user,
      content: params[:message_text],
      ai: false
    )

    # Broadcast user message to all event attendees
    broadcast_message(@message)

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

      # Broadcast AI message to all event attendees
      broadcast_message(@ai_message)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@chat) }
    end
  end

  def smart_replies
    @recent_messages = @chat.messages.order(created_at: :desc).limit(5)

    @smart_replies = AiChatService.generate_smart_replies(
      messages: @recent_messages,
      event: @chat.event
    )

    render json: { replies: @smart_replies }
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def authorize_chat_access
    event = @chat.event
    # Allow access if user is the event organizer or has confirmed attendance
    unless event.user == current_user || event.confirmations.exists?(user: current_user)
      redirect_to root_path, alert: "You don't have access to this chat."
    end
  end

  def broadcast_message(message)
    EventChannel.broadcast_to(
      @chat.event,
      {
        type: 'new_message',
        message: ApplicationController.render(
          partial: 'messages/message',
          locals: { message: message }
        ),
        message_id: message.id,
        sender_id: message.user_id
      }
    )
  end
end
