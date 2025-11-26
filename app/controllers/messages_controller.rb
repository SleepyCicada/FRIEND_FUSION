class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])

    @message = @chat.messages.create!(
      user: current_user,
      content: params[:message_text],
      ai: params[:ai] == "true" # store bool
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_path(@chat) }
    end
  end
end
