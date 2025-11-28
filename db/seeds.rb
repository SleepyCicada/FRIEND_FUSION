puts "Cleaning database..."

# CHILD TABLES FIRST
Message.destroy_all
AiMessage.destroy_all
Confirmation.destroy_all
Feedback.destroy_all

# TABLES THAT DEPEND ON EVENTS
Chat.destroy_all

# AI TABLES
AiChat.destroy_all

# EVENT TABLE
Event.destroy_all

# USERS LAST
User.destroy_all

# --- USER ---
user = User.create!(
  name: "Anna",
  email: "anna@example.com",
  password: "password"
)

# --- TOPICS ---
english   = Topic.create!(topic_description: "The language that borrowed from everyone...", topic_name: "English")
french    = Topic.create!(topic_description: "Even their sarcasm sounds aged in oak...", topic_name: "Français")
spanish   = Topic.create!(topic_description: "Passionate, rhythmic...", topic_name: "Español")
japanese  = Topic.create!(topic_description: "Polite, precise, a pun master...", topic_name: "Japanese")
italian   = Topic.create!(topic_description: "Speaks with their hands...", topic_name: "Italiano")
polish    = Topic.create!(topic_description: "Consonant gymnastics...", topic_name: "Polski")

# If you want even distribution:
topics = [english, french, spanish, japanese, italian, polish]

# --- EVENTS (each assigned one topic) ---

event_1 = Event.create!(
  title: "Coffee & Conversation ☕️",
  description: "Practice speaking in a relaxed café atmosphere",
  date_time: DateTime.new(2025, 12, 13),
  time: Time.parse("10:30"),
  topic: english,
  location: "1847 Maple Crest Road,  ON M0A 2K9"
)

event_1.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
  filename: "cafe.jpg",
  content_type: "image/jpeg"
)

event_2 = Event.create!(
  title: "Film & Discussion Club 🎬",
  description: "Watch a short film followed by a guided discussion",
  date_time: DateTime.new(2025, 12, 14),
  time: Time.parse("20:30"),
  topic: french,
  location: "92 Silver Grove Avenue, ON M0B 4T1"
)

event_2.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/movie.jpg")),
  filename: "movie.jpg",
  content_type: "image/jpeg"
)

event_3 = Event.create!(
  title: "Board Game Night 🎲",
  description: "Play classic board games adapted for language learners",
  date_time: DateTime.new(2025, 12, 19),
  time: Time.parse("20:00"),
  topic: spanish,
  location: "3300 Kingswell Street, ON M0C 1R4"
)

event_3.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/game.jpg")),
  filename: "game.jpg",
  content_type: "image/jpeg"
)

event_4 = Event.create!(
  title: "Cooking & Conversation Class 👨‍🍳",
  description: "Cook and practice conversations in a small group",
  date_time: DateTime.new(2025, 12, 16),
  time: Time.parse("11:00"),
  topic: italian,
  location: "557 Lakefront View Drive, ON M0A 9P2"
)

event_4.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/cook.jpg")),
  filename: "cook.jpg",
  content_type: "image/jpeg"
)

event_5 = Event.create!(
  title: "Survival Workshop 🗣",
  description: "Essential travel phrases and emergency conversation practice",
  date_time: DateTime.new(2025, 12, 17),
  time: Time.parse("18:00"),
  topic: japanese,
  location: "214 Brighton Hollow Lane, ON M0B 3L7"
)

event_5.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
  filename: "workshop.jpg",
  content_type: "image/jpeg"
)

event_6 = Event.create!(
  title: "Speed Networking 🗣",
  description: "Short timed rounds to practice introductions & small talk",
  date_time: DateTime.new(2025, 12, 19),
  time: Time.parse("19:00"),
  topic: french,
  location: "782 Forest Willow Crescent, ON M0A 6H3"
)

event_6.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/networking.jpg")),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

# Example: more events for English topic
event_7 = Event.create!(
  title: "Online Conversation Bootcamp 👥",
  description: "Mini debates & interactive prompts in a virtual setting",
  date_time: DateTime.new(2025, 12, 19),
  time: Time.parse("20:30"),
  topic: english,
  location: "45 Windermere Gate, ON M0C 7N1"
)

event_7.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/online.jpg")),
  filename: "online.jpg",
  content_type: "image/jpeg"
)

event_8 = Event.create!(
  title: "Study Buddy Matchup 📖",
  description: "Find a long-term partner for language progress",
  date_time: DateTime.new(2025, 12, 19),
  time: Time.parse("18:00"),
  topic: polish,
  location: "1209 Riverbend Parkway, ON M0A 5W4"
)

event_8.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/study.jpg")),
  filename: "study.jpg",
  content_type: "image/jpeg"
)

# --- EXTRA + CHAT ---
event = Event.create!(
  title: "French Café Meetup",
  description: "Practice French with newcomers.",
  date_time: DateTime.new(2025, 12, 01),
  time: Time.parse("16:00"),
  topic: french,
  location: "608 Cedarbrook Terrace, ON M0B 8Q6"
)

chat = Chat.create!(event: event)

5.times do
  Message.create!(
    user: user,
    chat: chat,
    content: Faker::Lorem.sentence
  )
end

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
