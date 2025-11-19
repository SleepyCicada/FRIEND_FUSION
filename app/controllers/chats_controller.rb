class ChatsController < ApplicationController
  def summary
    chat = Chat.find(params[:id])
    messages = chat.messages.order(created_at: :desc)

    summary = AiSummaryService.generate_chat_summary(messages, chat.event)

    render json: { summary: summary }
  end
end
