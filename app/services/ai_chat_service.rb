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
    response.is_a?(String) ? response : response.content.to_s
  rescue => e
    Rails.logger.error("AI chat error: #{e.message}")
    "I apologize, but I'm having trouble generating a response right now. Please try again."
  end

  # Generate AI response for event chat
  def self.generate_event_chat_reply(message:, user:, chat:, event:)
    # Build context from recent messages
    recent_messages = chat.messages.order(created_at: :desc).limit(10).reverse
    conversation_history = recent_messages.map do |msg|
      sender = msg.ai? ? "AI Assistant" : (msg.user&.name || "User")
      "#{sender}: #{msg.content}"
    end.join("\n")

    # Build comprehensive prompt with event context
    prompt = <<~PROMPT
      You are an AI assistant helping attendees of an event. Here's the event information:

      Event: #{event.title}
      Description: #{event.description}
      Location: #{event.location}
      Date: #{event.date_time&.strftime("%B %d, %Y at %I:%M %p") || "TBD"}
      Attendees: #{event.confirmations.count} people

      Recent conversation:
      #{conversation_history}

      Latest message from #{user.name}: #{message}

      Respond helpfully and naturally to the user's message. Be friendly, engaging, and relevant to the event context.
      Keep your response concise (2-3 sentences max) unless more detail is specifically requested.
      If asked about the event, provide accurate information. If asked questions beyond the event context,
      be helpful but guide the conversation back to the event when appropriate.
    PROMPT

    response = RubyLLM.chat.ask(prompt)
    response.is_a?(String) ? response : response.content.to_s
  rescue => e
    Rails.logger.error("AI event chat error: #{e.message}")
    "I'm having trouble generating a response right now. Please try again!"
  end

  # Generate smart reply suggestions based on conversation context
  def self.generate_smart_replies(messages:, event:)
    return [] if messages.empty?

    recent_context = messages.reverse.first(3).map do |msg|
      sender = msg.ai? ? "AI" : (msg.user&.name || "User")
      "#{sender}: #{msg.content}"
    end.join("\n")

    prompt = <<~PROMPT
      Based on this recent conversation about the event "#{event.title}":

      #{recent_context}

      Generate 3 short, natural quick reply suggestions (5-8 words each) that would make sense as responses.
      Return ONLY the replies, formatted as bullet points:

      - Reply 1
      - Reply 2
      - Reply 3
    PROMPT

    response = RubyLLM.chat.ask(prompt).to_s

    # Extract bullet points
    replies = response
      .lines
      .map(&:strip)
      .select { |line| line.start_with?("-", "•", "*") }
      .map { |line| line.sub(/^[-•*]\s*/, "") }
      .first(3)

    replies.presence || [
      "That sounds great!",
      "Tell me more",
      "I'm interested!"
    ]
  rescue => e
    Rails.logger.error("AI smart replies error: #{e.message}")
    [
      "That sounds great!",
      "Tell me more",
      "I'm interested!"
    ]
  end
end
