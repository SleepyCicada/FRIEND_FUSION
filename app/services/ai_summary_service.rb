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

    begin
      response = RubyLLM.chat.ask(prompt)
      response.is_a?(String) ? response : response.content.to_s
    rescue StandardError => e
      Rails.logger.error("AI chat summary error: #{e.message}")
      "Unable to generate summary at this time. Please try again later."
    end
  end
end
