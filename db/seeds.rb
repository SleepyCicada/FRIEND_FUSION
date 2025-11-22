# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create a test user
Message.destroy_all
Chat.destroy_all
Topic.destroy_all
Event.destroy_all
AiChat.destroy_all
AiMessage.destroy_all
User.destroy_all

user = User.create!(
  name: "Anna",
  email: "anna@example.com",
  password: "password"
)

topic1 =Topic.create!( topic_description: "The language that borrowed from everyone, forgot to return it, and now makes the rules up as it goes.", topic_name: "English"),
topic2 =Topic.create!( topic_description: "Even their sarcasm sounds like it’s been aged in oak barrels and served with cheese.", topic_name: "Français"),
topic3 =Topic.create!( topic_description: "Passionate, rhythmic, and always ready to dance. Rolls their R’s like maracas.", topic_name: "Español"),
topic4 =Topic.create!( topic_description: "Polite, precise, and secretly a pun master. Brings origami and philosophical haikus.", topic_name: "Japanese"),
topic5 =Topic.create!( topic_description: "Speaks with their hands, sings their sentences, and turns every conversation into an opera.", topic_name: "Italiano"),
topic6 =Topic.create!( topic_description: "Consonant gymnastics. Can say “przyszczyna” without blinking.", topic_name: "Polski")

# Create an event
event = Event.new(
  title: "French Café Meetup",
  description: "Practice French with newcomers.",
  date_time: Time.now + 3.days
)
event.topic = topic2
event.save

# Create the pre-event chat
chat = Chat.create!(event: event)

# Add sample messages
5.times do
  Message.create!(
    user: user,
    chat: chat,
    content: Faker::Lorem.sentence
  )
end

# Create an AI chat assistant
ai_chat = AiChat.create!(
  user: user,
  language_target: "French",
  persona: "Friendly coach",
  settings: { tone: "warm", style: "helpful" }
)

# Add an AI message example
AiMessage.create!(
  ai_chat: ai_chat,
  user: user,
  sender_type: :user,
  content: "How do I introduce myself?"
)
