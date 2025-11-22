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
end
