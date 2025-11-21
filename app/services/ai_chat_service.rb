class AiChatService
  def self.generate_reply(message:, user:, ai_chat:)
    prompt = <<~PROMPT
      You are a helpful language-learning assistant.
      User's target language: #{ai_chat.language_target || "English"}
      Persona: #{ai_chat.persona || "friendly"}.

      User says: #{message}
      Reply in a friendly way to keep the conversation going.
    PROMPT

    RubyLLM.chat.ask(prompt)
  end
end
