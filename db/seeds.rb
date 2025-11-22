# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
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

english =Topic.create!( topic_description: "The language that borrowed from everyone, forgot to return it, and now makes the rules up as it goes.", topic_name: "English")
french =Topic.create!( topic_description: "Even their sarcasm sounds like it’s been aged in oak barrels and served with cheese.", topic_name: "Français")
spanish =Topic.create!( topic_description: "Passionate, rhythmic, and always ready to dance. Rolls their R’s like maracas.", topic_name: "Español")
japanese =Topic.create!( topic_description: "Polite, precise, and secretly a pun master. Brings origami and philosophical haikus.", topic_name: "Japanese")
italian =Topic.create!( topic_description: "Speaks with their hands, sings their sentences, and turns every conversation into an opera.", topic_name: "Italiano")
polish =Topic.create!( topic_description: "Consonant gymnastics. Can say “przyszczyna” without blinking.", topic_name: "Polski")

topics = [english, french, spanish, japanese, italian, polish]

event_1 = Event.create!(
 title: "Coffee & Conversation - english☕️",
 description: "Practice speaking in a relaxed café atmosphere",
 date_time: DateTime.new(2025, 12, 13),
 topic: english
)

event_1.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
 filename: "cafe.jpg",
 content_type: "image/jpeg"
)


event_2 = Event.create!(
 title: "Film & Discussion Club - french 🎬",
 description: "Watch a short film followed by a guided discussion",
 date_time: DateTime.new(2025, 12, 14),
 topic: french
)


event_2.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/movie.jpg")),
 filename: "movie.jpg",
 content_type: "image/jpeg"
)


event_3 = Event.create!(
 title: "Board Game Night - Spanish 🎲",
 description: "Play classic board games adapted for language learners",
 date_time: DateTime.new(2025, 12, 19),
 topic: spanish
)


event_3.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/game.jpg")),
 filename: "game.jpg",
 content_type: "image/jpeg"
)


event_4 = Event.create!(
 title: "Cooking & Conversation Class - Japanese 👨‍🍳 ",
 description: "Learn to cook a simple dish while practicing with a small group",
 date_time: DateTime.new(2025, 12, 16),
 topic: japanese
)


event_4.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/cook.jpg")),
 filename: "cook.jpg",
 content_type: "image/jpeg"
)


event_5 = Event.create!(
 title: "Survival Workshop - Italian 🗣 ",
 description: "A small-group mini lesson covering essential phrases for travel and more",
 date_time: DateTime.new(2025, 12, 17),
 topic: italian
)


event_5.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
 filename: "workshop.jpg",
 content_type: "image/jpeg"
)


event_6 = Event.create!(
  title: "Speed Networking - Polish🗣 ",
  description: "Meet multiple partners in short, timed rounds. Practice introductions, small talk and more",
  date_time: DateTime.new(2025, 12, 19),
  topic: polish
)

event_6.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/networking.jpg")),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

event_7 = Event.create!(
  title: "Online Conversation Bootcamp - English 👥",
  description: "Timed rounds, mini debates, and interactive prompts in a virtual setting",
  date_time: DateTime.new(2025, 12, 19),
  topic: english
)

event_7.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/online.jpg")),
  filename: "online.jpg",
  content_type: "image/jpeg"
)
event_8 = Event.create!(
  title: "Study Buddy Matchup - French 📖",
  description: "Pair learners for long-term language progress",
  date_time: DateTime.new(2025, 12, 19),
  topic: french
)

event_8.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/study.jpg")),
  filename: "study.jpg",
  content_type: "image/jpeg"
)

# Create an event
event = Event.create!(
  title: "French Café Meetup",
  description: "Practice French with newcomers.",
  date_time: Date.today + 3.days,
  topic: french
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
)
