# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
<<<<<<< HEAD

event_1 = Event.create!(
  name: "Coffee & Conversation",
  description: "Practice speaking in a relaxed café atmosphere ☕️ "
)

event_1.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
  filename: "cafe.jpg",
  content_type: "image/jpeg"
=======
# Create a test user
user = User.create!(
  name: "Anna",
  email: "anna@example.com",
  password: "password"
)

# Create an event
event = Event.create!(
  title: "French Café Meetup",
  description: "Practice French with newcomers.",
  date_time: Time.now + 3.days
)

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
>>>>>>> master
)
