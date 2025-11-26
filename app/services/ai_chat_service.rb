class AiChatService
  def self.generate_conversation_starters(event)
    prompt = <<~PROMPT
      Give me 3 friendly, short conversation starters for this event:

      #{event.title} — #{event.description}

      Return ONLY the starters, formatted as bullet points:

      - Starter 1
      - Starter 2
      - Starter 3
    PROMPT

    response = RubyLLM.chat.ask(prompt).to_s

    # Extract only bullet points
    starters = response
      .lines
      .map(&:strip)
      .select { |line| line.start_with?("-", "•", "*") }
      .map { |line| line.sub(/^[-•*]\s*/, "") } # remove bullet symbol

    starters
  end

  def self.generate_reply(message:, user:, ai_chat:)
    # Build context from previous messages
    previous_messages = ai_chat.ai_messages.order(created_at: :asc).last(10)
    conversation_history = previous_messages.map do |msg|
      "#{msg.sender_type == 'user' ? user.name || 'User' : 'Assistant'}: #{msg.content}"
    end.join("\n")

    # Build system prompt based on AI chat settings
    system_context = []
    system_context << "You are #{ai_chat.persona}" if ai_chat.persona.present?
    system_context << "The user is learning #{ai_chat.language_target}" if ai_chat.language_target.present?

    prompt = <<~PROMPT
      #{system_context.join(". ")}.

      Previous conversation:
      #{conversation_history}

      User: #{message}

      Respond naturally and helpfully to the user's message.
    PROMPT

    response = RubyLLM.chat.ask(prompt)

    # Handle both string and object responses
    response.is_a?(String) ? response : response.text
  rescue => e
    Rails.logger.error("AI chat error: #{e.message}")
    "I apologize, but I'm having trouble generating a response right now. Please try again."
  end
end
