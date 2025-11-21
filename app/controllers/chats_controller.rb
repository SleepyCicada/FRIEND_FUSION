class ChatsController < ApplicationController
  def summary
    @chat = Chat.find(params[:id])
    messages = @chat.messages.order(created_at: :asc)

    @summary = AiSummaryService.generate_chat_summary(messages, @chat.event)

    respond_to do |format|
      format.turbo_stream
      format.json { render json: { summary: @summary } }
    end
  end
end
