class AiStarterService
  def self.generate_event_starters(event, user)
    event_context = <<~INFO
      Event Title: #{event.title}
      Description: #{event.description}
      Location: #{event.location if event.respond_to?(:location)}
      Date/Time: #{event.date_time}
    INFO

    user_context = <<~USERINFO
      User Name: #{user.name}
      Interests: #{user.interests if user.respond_to?(:interests)}
      Language Level: #{user.language_level if user.respond_to?(:language_level)}
    USERINFO

    prompt = <<~PROMPT
      Generate 3 short, friendly conversation starters for someone attending this event.
      They should be simple, natural and welcoming for newcomers to a city.

      Event information:
      #{event_context}

      User information:
      #{user_context}
    PROMPT

    result = RubyLLM.chat(prompt)
    result.split("\n").reject(&:blank?)
  end
end
