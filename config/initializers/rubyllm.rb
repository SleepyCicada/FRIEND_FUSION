RubyLLM.configure do |config|
  config.openai_api_key = ENV["OPENAI_API_KEY"]
  config.openai_api_base = "https://api.openai.com/v1"
end
