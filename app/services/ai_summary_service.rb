class AiSummaryService
  def self.generate_chat_summary(messages, event)
    text = messages.map { |m| "#{m.user&.name || 'User'}: #{m.content}" }.join("\n")

    prompt = <<~PROMPT
      Summarize this chat in 2–3 sentences.
      Focus on questions, introductions, and plans made by participants.

      Event Title: #{event.title}
      Chat:
      #{text}
    PROMPT

    response = RubyLLM.chat.ask(prompt)
    raw = response.content
    raw.is_a?(String) ? raw : raw.text
  end
end
