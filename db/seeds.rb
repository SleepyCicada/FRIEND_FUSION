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
require "open-uri"

puts "Cleaning database..."
Message.destroy_all
Chat.destroy_all
Event.destroy_all
AiChat.destroy_all
AiMessage.destroy_all
User.destroy_all

puts "Creating user..."
user = User.create!(
  name: "Anna",
  email: "anna@example.com",
  password: "password"
)

puts "Creating events..."

event_1 = Event.create!(
  title: "Coffee & Conversation",
  description: "Practice speaking in a relaxed café atmosphere ☕️",
  date_time: DateTime.new(2025, 12, 13, 17, 0)
)

event_1.image.attach(
  io: URI.open("https://images.unsplash.com/photo-1504754524776-8f4f37790ca0"),
  filename: "cafe.jpg",
  content_type: "image/jpeg"
)

event_2 = Event.create!(
  title: "Film & Discussion Club",
  description: "Watch a short film followed by a guided discussion 🎬",
  date_time: DateTime.new(2025, 12, 14, 19, 0)
)

event_2.image.attach(
  io: URI.open("https://images.unsplash.com/photo-1524985069026-dd778a71c7b4"),
  filename: "movie.jpg",
  content_type: "image/jpeg"
)

puts "Creating chats with messages..."

chat_1 = Chat.create!(event: event_1)
chat_2 = Chat.create!(event: event_2)


5.times do
  Message.create!(
    user: user,
    chat: chat_1,
    content: Faker::Lorem.sentence
  )
end

puts "Creating AI Chat..."

ai_chat = AiChat.create!(
  user: user,
  language_target: "French",
  persona: "Friendly coach",
  settings: { tone: "warm", style: "helpful" }
)

AiMessage.create!(
  ai_chat: ai_chat,
  user: user,
  sender_type: :user,
  content: "How do I introduce myself?"
)

puts "Seed completed successfully!"
