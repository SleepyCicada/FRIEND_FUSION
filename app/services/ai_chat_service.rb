class AiChatService
  def self.generate_reply(message:, user:, ai_chat:)
    persona = ai_chat.persona || "friendly language assistant"
    target = ai_chat.language_target || "English"
    settings = ai_chat.settings || { "tone" => "friendly", "style" => "helpful" }

    system_prompt = <<~PROMPT
      You are a #{persona}.
      Your tone should be #{settings['tone'] || 'friendly'}.
      Your style should be #{settings['style'] || 'clear' }.
      Your goal is to help the user practice #{target},
      correct grammar softly, and provide simple, natural-sounding phrasing.
    PROMPT

    RubyLLM.chat(
      system: system_prompt,
      message: message
    )
  end
end
