Message.destroy_all
Chat.destroy_all
Topic.destroy_all
Event.destroy_all
AiChat.destroy_all
AiMessage.destroy_all
User.destroy_all

# --- USER ---
user = User.create!(
  name: "Anna",
  email: "anna@example.com",
  password: "password"
)

# --- TOPICS ---
english    = Topic.create!(topic_description: "Global lingua franca with words borrowed from every corner of the world", topic_name: "English")
french     = Topic.create!(topic_description: "The language of diplomacy, romance, and culinary excellence", topic_name: "Français")
spanish    = Topic.create!(topic_description: "Spoken across continents with passionate rhythm and vibrant expression", topic_name: "Español")
japanese   = Topic.create!(topic_description: "Ancient traditions meet modern innovation in honorific harmony", topic_name: "Japanese")
italian    = Topic.create!(topic_description: "Expressive gestures and melodic tones from the heart of art and cuisine", topic_name: "Italiano")
polish     = Topic.create!(topic_description: "Slavic complexity with consonant clusters that challenge and delight", topic_name: "Polski")
german     = Topic.create!(topic_description: "Precision engineering meets poetic compound words and philosophical depth", topic_name: "Deutsch")
portuguese = Topic.create!(topic_description: "From Lisbon to Rio, music flows through every sentence and samba beat", topic_name: "Português")
mandarin   = Topic.create!(topic_description: "Four tones unlock infinite meanings in the world's most spoken language", topic_name: "中文")
korean     = Topic.create!(topic_description: "Systematic alphabet and nuanced honorifics that show respect in every word", topic_name: "한국어")
arabic     = Topic.create!(topic_description: "Written right to left, flowing script connecting cultures across continents", topic_name: "العربية")
russian    = Topic.create!(topic_description: "Cyrillic elegance carrying centuries of soul-stirring literature and tradition", topic_name: "Русский")

# If you want even distribution:
topics = [english, french, spanish, japanese, italian, polish, german, portuguese, mandarin, korean, arabic, russian]

# --- EVENTS (each assigned one topic) ---

event_1 = Event.create!(
  title: "Coffee & Conversation ☕️",
  description: "Practice speaking in a relaxed café atmosphere",
  date_time: DateTime.new(2025, 12, 13),
  topic: english,
  user: user
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
  topic: french,
  user: user
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
  topic: spanish,
  user: user
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
  topic: italian,
  user: user
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
  topic: japanese,
  user: user
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
  topic: french,
  user: user
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
  topic: english,
  user: user
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
  topic: polish,
  user: user
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
  date_time: Date.today + 3.days,
  topic: french,
  user: user
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
