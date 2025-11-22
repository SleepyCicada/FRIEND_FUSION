# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Event.destroy_all

user1 = User.create!(email: "florimelle@gmail.com", password: "345678")

event_1 = Event.create!(
 title: "Coffee & Conversation ☕️",
 description: "Practice speaking in a relaxed café atmosphere",
 date_time: DateTime.new(2025, 12, 13)
)

event_1.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
 filename: "cafe.jpg",
 content_type: "image/jpeg"
)


event_2 = Event.create!(
 title: "Film & Discussion Club 🎬",
 description: "Watch a short film followed by a guided discussion",
 date_time: DateTime.new(2025, 12, 14)
)


event_2.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/movie.jpg")),
 filename: "movie.jpg",
 content_type: "image/jpeg"
)


event_3 = Event.create!(
 title: "Board Game Night 🎲",
 description: "Play classic board games adapted for language learners",
 date_time: DateTime.new(2025, 12, 19)
)


event_3.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/game.jpg")),
 filename: "game.jpg",
 content_type: "image/jpeg"
)


event_4 = Event.create!(
 title: "Cooking & Conversation Class 👨‍🍳 ",
 description: "Learn to cook a simple dish while practicing with a small group",
 date_time: DateTime.new(2025, 12, 16)
)


event_4.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/cook.jpg")),
 filename: "cook.jpg",
 content_type: "image/jpeg"
)


event_5 = Event.create!(
 title: "Survival Workshop 🗣 ",
 description: "A small-group mini lesson covering essential phrases for travel and more",
 date_time: DateTime.new(2025, 12, 17)
)


event_5.image.attach(
 io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
 filename: "workshop.jpg",
 content_type: "image/jpeg"
)


event_6 = Event.create!(
  title: "Speed Networking 🗣 ",
  description: "Meet multiple partners in short, timed rounds. Practice introductions, small talk and more",
  date_time: DateTime.new(2025, 12, 19)
)

event_6.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/networking.jpg")),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

event_7 = Event.create!(
  title: "Online Conversation Bootcamp 👥",
  description: "Timed rounds, mini debates, and interactive prompts in a virtual setting",
  date_time: DateTime.new(2025, 12, 19)
)

event_7.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/online.jpg")),
  filename: "online.jpg",
  content_type: "image/jpeg"
)
event_8 = Event.create!(
  title: "Study Buddy Matchup 📖",
  description: "Pair learners for long-term language progress",
  date_time: DateTime.new(2025, 12, 19)
)

event_8.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/study.jpg")),
  filename: "study.jpg",
  content_type: "image/jpeg"
)
