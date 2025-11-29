class AiStarterService
  def self.generate_event_starters(event, user)
    prompt = <<~PROMPT
      Generate exactly 3 short, friendly conversation starters.
      They MUST be formatted like:

      1. ...
      2. ...
      3. ...

      Do NOT include any introduction.
      Do NOT include any conclusion.
      Do NOT include any greetings.
      Only return the 3 lines.

      Event:
      Title: #{event.title}
      Description: #{event.description}
      Date: #{event.date_time}

      User:
      Name: #{user.name}
    PROMPT

    # Ask the AI
    begin
      response = RubyLLM.chat.ask(prompt)
      text = response.content.to_s

      # Split lines + strip whitespace
      lines = text.split("\n").map(&:strip).reject(&:blank?)

      # Extract ONLY numbered lines
      starters = lines.select { |line| line.match?(/^\d+\./) }

      # Remove the "1. " prefix
      starters.map! { |line| line.sub(/^\d+\.\s*/, "") }

      return starters
    rescue StandardError => e
      Rails.logger.error("AI starter generation error: #{e.message}")
      return [] # Return empty array as fallback
    end
  end
end
