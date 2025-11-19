class AiSummaryService
  def self.generate_chat_summary(messages, event)
    chat_context = messages.map do |msg|
      "#{msg.user.name}: #{msg.content}"
    end.join("\n")

    event_context = <<~INFO
      Event Title: #{event.title}
      Date/Time: #{event.date_time}
    INFO

    prompt = <<~PROMPT
      Summarize the following event chat in 2-3 friendly sentences.
      Focus on:
      - Introductions
      - Plans made
      - Questions asked & answered
      - Tips shared
      - Anything newcomers should know

      Chat messages:
      #{chat_context}

      Event:
      #{event_context}
    PROMPT

    RubyLLM.chat(prompt)
  end
end
