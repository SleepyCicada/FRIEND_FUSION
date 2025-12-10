require 'open-uri'

puts "Cleaning database..."

# CHILD TABLES FIRST
Message.destroy_all
AiMessage.destroy_all
Confirmation.destroy_all
Feedback.destroy_all
Notification.destroy_all

# TABLES THAT DEPEND ON EVENTS
Chat.destroy_all

# AI TABLES
AiChat.destroy_all

# EVENT TABLE
Event.destroy_all

# TOPIC TABLE
Topic.destroy_all

# USERS LAST
User.destroy_all

puts "Creating test data..."

# --- USERS ---
user = User.create!(
  name: "Ceci",
  email: "ceci@example.com",
  password: "password"
)

user2 = User.create!(
  name: "Middwin",
  email: "middwin@example.com",
  password: "password"
)

user3 = User.create!(
  name: "Flo",
  email: "Flo@example.com",
  password: "password"
)

user4 = User.create!(
  name: "Pavel",
  email: "pavel@example.com",
  password: "password"
)

user5 = User.create!(
  name: "Frank",
  email: "frank@example.com",
  password: "password"
)

user6 = User.create!(
  name: "Wanji",
  email: "wanji@example.com",
  password: "password"
)

user7 = User.create!(
  name: "Sherliene",
  email: "sherliene@example.com",
  password: "password"
)
# --- TOPICS ---
english    = Topic.create!(topic_description: "🇬🇧 Hello! Learn a new language & meet now people today!", topic_name: "English")
french     = Topic.create!(topic_description: "🇫🇷 Salut! Learn a new language & meet now people today!", topic_name: "Français")
spanish    = Topic.create!(topic_description: "🇪🇸 ¡¡Hola!! Learn a new language & meet now people today!", topic_name: "Español")
japanese   = Topic.create!(topic_description: "🇯🇵 こんにちは！Learn a new language & meet now people today!", topic_name: "Japanese")
italian    = Topic.create!(topic_description: "🇮🇹 Ciao! Learn a new language & meet now people today!", topic_name: "Italiano")
polish     = Topic.create!(topic_description: "🇵🇱 Cześć! Learn a new language & meet now people today!", topic_name: "Polski")
german     = Topic.create!(topic_description: "🇩🇪 Hallo! Learn a new language & meet now people today!", topic_name: "Deutsch")
portuguese = Topic.create!(topic_description: "🇵🇹 Olá!! Learn a new language & meet now people today!", topic_name: "Português")
mandarin   = Topic.create!(topic_description: "🇨🇳 你好！Learn a new language & meet now people today!", topic_name: "中文")
korean     = Topic.create!(topic_description: "🇰🇷 안녕하세요! Learn a new language & meet now people today!", topic_name: "한국어")
arabic     = Topic.create!(topic_description: "🇦🇪 مرحباً! Learn a new language & meet now people today!", topic_name: "العربية")
russian    = Topic.create!(topic_description: "🇷🇺 Привет! Learn a new language & meet now people today!", topic_name: "Русский")

# If you want even distribution:
topics = [english, french, spanish, japanese, italian, polish, german, portuguese, mandarin, korean, arabic, russian]

# --- EVENTS (each assigned one topic) ---

# Past events (with end_time in the past - for feedback testing)
event_1 = Event.create!(
  title: "Coffee & Conversation ☕️",
  description: "Practice speaking in a relaxed café atmosphere",
  date_time: DateTime.new(2025, 11, 13, 10, 0),
  end_time: DateTime.new(2025, 11, 13, 12, 0),
  topic: english,
  user: user,
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9"
)

event_1.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896125/cafe_hm5tsq.jpg"),
  filename: "cafe.jpg",
  content_type: "image/jpeg"
)

event_2 = Event.create!(
  title: "Film & Discussion Club 🎬",
  description: "Watch a short film followed by a guided discussion",
  date_time: DateTime.new(2025, 11, 14, 18, 0),
  end_time: DateTime.new(2025, 11, 14, 21, 0),
  topic: french,
  user: user,
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9"
)

event_2.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896160/movie_krp9k0.jpg"),
  filename: "movie.jpg",
  content_type: "image/jpeg"
)

event_3 = Event.create!(
  title: "Board Game Night 🎲",
  description: "Play classic board games adapted for language learners",
  date_time: DateTime.new(2025, 11, 19, 19, 0),
  end_time: DateTime.new(2025, 11, 19, 22, 0),
  topic: spanish,
  user: user2,
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9"
)

event_3.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896169/game_buxwsz.jpg"),
  filename: "game.jpg",
  content_type: "image/jpeg"
)

# Future events (no feedback yet)
event_4 = Event.create!(
  title: "Cooking & Conversation Class 👨‍🍳",
  description: "Cook and practice conversations in a small group",
  date_time: DateTime.new(2025, 12, 16, 15, 0),
  end_time: DateTime.new(2025, 12, 16, 18, 0),
  topic: italian,
  user: user,
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9"
)

event_4.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896177/cook_jkviyy.jpg"),
  filename: "cook.jpg",
  content_type: "image/jpeg"
)

event_5 = Event.create!(
  title: "Survival Workshop 🗣",
  description: "Essential travel phrases and emergency conversation practice",
  date_time: DateTime.new(2025, 12, 17, 14, 0),
  end_time: DateTime.new(2025, 12, 17, 16, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: japanese,
  user: user2
)

event_5.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896188/trivia_of7lho.jpg"),
  filename: "workshop.jpg",
  content_type: "image/jpeg"
)

event_6 = Event.create!(
  title: "Speed Networking 🗣",
  description: "Short timed rounds to practice introductions & small talk",
  date_time: DateTime.new(2025, 12, 19, 17, 0),
  end_time: DateTime.new(2025, 12, 19, 19, 0),
  topic: french,
  user: user,
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9"
)

event_6.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039192/Speed_Networking_uj8wwp.jpg"),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

event_7 = Event.create!(
  title: "Online Conversation Bootcamp 👥",
  description: "Mini debates & interactive prompts in a virtual setting",
  date_time: DateTime.new(2025, 12, 20, 10, 0),
  end_time: DateTime.new(2025, 12, 20, 12, 0),
  location: "Online",
  topic: english,
  user: user,
)

event_7.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896191/online_usxema.jpg"),
  filename: "online.jpg",
  content_type: "image/jpeg"
)

event_8 = Event.create!(
  title: "Study Buddy Matchup 📖",
  description: "Find a long-term partner for language progress",
  date_time: DateTime.new(2025, 12, 21, 13, 0),
  end_time: DateTime.new(2025, 12, 21, 15, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: polish,
  user: user2
)

event_8.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1764896154/vitaly-gariev-eQlU4-7PGHw-unsplash_l7u3qk.jpg"),
  filename: "study.jpg",
  content_type: "image/jpeg"
)

# --- CONFIRMATIONS ---
puts "Creating confirmations..."

# ========================================
# ATTENDEE PHOTOS - CLOUDINARY LINKS
# ========================================
# To add attendee photos, insert cloudinary URLs here for each user
# Then attach photos to user avatars or confirmation records
# #
# # Example:
# # user2.photo.attach(io: URI.open("YOUR_CLOUDINARY_LINK_HERE"), filename: "avatar.jpg", content_type: "image/jpeg")
# #
# # Cloudinary links for attendees:
# # user (Ceci): [INSERT_CLOUDINARY_LINK_HERE]
# # # user2 (Middwin): [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041670/Middwin_xydzch.png]
# # user3 (Flo): [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041676/Flo_ljuinv.png]
# # # user4 (Pavel): [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041674/Pavel_bgv7ve.png]
# # # user5 (Frank): [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041673/Frank_k2xxpl.png]
# # # user6 (Wanji): [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041670/Wanji_nje50u.png]
# # # user7 (Sherliene): [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041671/Sherliene_ipctq8.png]
# # # rachel: [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041676/Rachel_b9f1em.png]
# # # antoine: [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041671/Antoine_nstc0g.png]
# # # mg: [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041675/MG_lzyudo.png]
# # nadia: [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041677/Nadia_woujaq.png]
# # # enrique: [https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041672/Enrique_gfucma.png]
# # # ========================================

# Event 1 attendees
Confirmation.create!(user: user2, event: event_1)
Confirmation.create!(user: user3, event: event_1)
Confirmation.create!(user: user4, event: event_1)
Confirmation.create!(user: user5, event: event_1)

# Event 2 attendees
Confirmation.create!(user: user3, event: event_2)
Confirmation.create!(user: user4, event: event_2)
Confirmation.create!(user: user5, event: event_2)
Confirmation.create!(user: user6, event: event_2)

# Event 3 attendees
Confirmation.create!(user: user, event: event_3)
Confirmation.create!(user: user3, event: event_3)
Confirmation.create!(user: user4, event: event_3)
Confirmation.create!(user: user5, event: event_3)
Confirmation.create!(user: user6, event: event_3)

# Event 4 attendees (future)
Confirmation.create!(user: user2, event: event_4)
Confirmation.create!(user: user3, event: event_4)
Confirmation.create!(user: user4, event: event_4)
Confirmation.create!(user: user5, event: event_4)

# Event 5 attendees (future)
Confirmation.create!(user: user, event: event_5)
Confirmation.create!(user: user3, event: event_5)
Confirmation.create!(user: user4, event: event_5)
Confirmation.create!(user: user5, event: event_5)
Confirmation.create!(user: user6, event: event_5)

# --- FEEDBACKS ---
puts "Creating feedbacks..."

# Feedbacks for Event 1 (past event)
Feedback.create!(
  user: user2,
  event: event_1,
  rating: 5,
  comment: "Absolutely loved this event! The atmosphere was perfect for practicing English, and everyone was so friendly and supportive. Can't wait for the next one!"
)

Feedback.create!(
  user: user3,
  event: event_1,
  rating: 4,
  comment: "Great experience overall. The café was a bit noisy at times, but the conversations were engaging and I learned a lot. Would definitely recommend!"
)

Feedback.create!(
  user: user4,
  event: event_1,
  rating: 5,
  comment: "This was my first language meetup and it exceeded all expectations! Ceci did a fantastic job organizing everything. The coffee was great too!"
)

# Feedbacks for Event 2 (past event)
Feedback.create!(
  user: user3,
  event: event_2,
  rating: 5,
  comment: "The film selection was perfect for our level. The discussion afterwards really helped me practice my French in a natural way. Merci beaucoup!"
)

Feedback.create!(
  user: user4,
  event: event_2,
  rating: 4,
  comment: "Really enjoyed the film and the discussion. Would have liked a bit more time for conversation practice, but overall a wonderful evening."
)

Feedback.create!(
  user: user6,
  event: event_2,
  rating: 5,
  comment: "Excellent event! The movie was engaging and the discussion questions were thought-provoking. Perfect mix of entertainment and learning."
)

# Feedbacks for Event 3 (past event)
Feedback.create!(
  user: user,
  event: event_3,
  rating: 5,
  comment: "Marcus organized an amazing game night! The board games were a fun way to practice Spanish naturally. Everyone was laughing and learning at the same time."
)

Feedback.create!(
  user: user3,
  event: event_3,
  rating: 4,
  comment: "Fun night! The games were well-chosen for language practice. Would love to see more variety in game types next time."
)

Feedback.create!(
  user: user5,
  event: event_3,
  rating: 5,
  comment: "Best language event I've attended! The competitive element of the games made learning Spanish so much more engaging. Marcus was an excellent host!"
)

# --- NOTIFICATIONS ---
puts "Creating notifications..."

# Event registration confirmations
Notification.create!(
  user: user2,
  message: "You're registered for Coffee & Conversation ☕️ on Nov 13 at 10:00 AM",
  read: true,
  created_at: 5.days.ago
)

Notification.create!(
  user: user3,
  message: "You're registered for Coffee & Conversation ☕️ on Nov 13 at 10:00 AM",
  read: true,
  created_at: 5.days.ago
)

# New attendee notifications for event organizers
Notification.create!(
  user: user,
  message: "Marcus has joined your event: Coffee & Conversation ☕️",
  read: true,
  created_at: 4.days.ago
)

Notification.create!(
  user: user,
  message: "Sofia has joined your event: Coffee & Conversation ☕️",
  read: true,
  created_at: 4.days.ago
)

Notification.create!(
  user: user2,
  message: "Ceci has joined your event: Board Game Night 🎲",
  read: false,
  created_at: 3.days.ago
)

# Event reminders for upcoming events
Notification.create!(
  user: user,
  message: "Reminder: Cooking & Conversation Class 👨‍🍳 is tomorrow at 3:00 PM",
  read: false,
  created_at: 1.day.ago
)

Notification.create!(
  user: user2,
  message: "Reminder: Cooking & Conversation Class 👨‍🍳 starts in 24 hours",
  read: false,
  created_at: 1.day.ago
)

Notification.create!(
  user: user3,
  message: "Reminder: Survival Workshop 🗣 is coming up on Dec 17",
  read: false,
  created_at: 2.days.ago
)

# Feedback requests for past events
Notification.create!(
  user: user2,
  message: "How was Coffee & Conversation ☕️? Share your feedback to help others!",
  read: true,
  created_at: 3.days.ago
)

Notification.create!(
  user: user3,
  message: "Please rate your experience at Film & Discussion Club 🎬",
  read: false,
  created_at: 2.days.ago
)

# New messages in event chat
Notification.create!(
  user: user,
  message: "New messages in Coffee & Conversation ☕️ chat",
  read: false,
  created_at: 6.hours.ago
)

Notification.create!(
  user: user2,
  message: "James sent a message in Coffee & Conversation ☕️ chat",
  read: false,
  created_at: 3.hours.ago
)

# Event updates and changes
Notification.create!(
  user: user4,
  message: "Important: Location updated for Coffee & Conversation ☕️",
  read: true,
  created_at: 5.days.ago
)

Notification.create!(
  user: user5,
  message: "The organizer posted an update for Speed Networking 🗣",
  read: false,
  created_at: 12.hours.ago
)

# AI chat interactions
Notification.create!(
  user: user,
  message: "Kai has generated conversation starters for Cooking & Conversation Class 👨‍🍳",
  read: false,
  created_at: 8.hours.ago
)

Notification.create!(
  user: user3,
  message: "Chat summary is ready for Film & Discussion Club 🎬",
  read: true,
  created_at: 2.days.ago
)

# Event capacity updates
Notification.create!(
  user: user,
  message: "Your event Coffee & Conversation ☕️ is almost full! (4/5 spots taken)",
  read: true,
  created_at: 4.days.ago
)

Notification.create!(
  user: user2,
  message: "Board Game Night 🎲 is now full! 5 people registered",
  read: false,
  created_at: 1.day.ago
)

# General notifications
Notification.create!(
  user: user,
  message: "Welcome to FriendFusion! 🎉 Start by creating your first event or joining one",
  read: true,
  created_at: 7.days.ago
)

Notification.create!(
  user: user5,
  message: "You have 3 upcoming events this week. Check your calendar!",
  read: false,
  created_at: 10.hours.ago
)

Notification.create!(
  user: user6,
  message: "New events in your favorite topic: Français 🇫🇷",
  read: false,
  created_at: 5.hours.ago
)

# Cancellation/Changes
Notification.create!(
  user: user4,
  message: "Time changed: Film & Discussion Club 🎬 now starts at 6:00 PM",
  read: true,
  created_at: 6.days.ago
)

# Social notifications
Notification.create!(
  user: user,
  message: "Marcus left a review on your event Coffee & Conversation ☕️: ⭐⭐⭐⭐⭐",
  read: false,
  created_at: 2.days.ago
)

Notification.create!(
  user: user2,
  message: "Ceci left a 5-star review on Board Game Night 🎲!",
  read: false,
  created_at: 1.day.ago
)

# More attendee notifications
Notification.create!(
  user: user,
  message: "Chen has joined Speed Networking 🗣",
  read: false,
  created_at: 4.hours.ago
)

Notification.create!(
  user: user3,
  message: "Priya confirmed attendance for Korean Drama Watch Party 📺",
  read: false,
  created_at: 2.hours.ago
)

# --- CHAT DEMOS WITH MULTI-USER CONVERSATIONS ---

# Only keeping chats for Le Wagon Demo Day and Study Buddy Matchup

# Chat: Study Buddy Matchup (Polish)
chat_study = event_8.chat
Message.create!(user: user, chat: chat_study, content: "Hi everyone! Looking forward to finding a study partner for Polish. Anyone else learning from scratch?", ai: false)
Message.create!(user: user3, chat: chat_study, content: "Hey! I've been learning Polish for about 3 months now. Would love to find someone to practice with regularly!", ai: false)
Message.create!(user: user4, chat: chat_study, content: "This is perfect timing! I've been struggling with Polish pronunciation and could really use a study buddy.", ai: false)
Message.create!(user: user5, chat: chat_study, content: "Count me in! I'm at beginner level but super committed. Looking for someone who wants to practice 2-3 times a week.", ai: false)
Message.create!(user: user3, chat: chat_study, content: "Priya, that sounds great! I'm also looking for regular practice sessions. Should we exchange schedules at the event?", ai: false)
Message.create!(user: user, chat: chat_study, content: "This is exactly why I love these meetups! Already seeing great connections forming. See you all on Saturday!", ai: false)

# --- ADDITIONAL EVENTS (12 more events: 6 past, 6 future) ---

# Marcus's additional past event
event_9 = Event.create!(
  title: "Cultural Exchange Dinner 🍽",
  description: "Share dishes from your culture and practice language skills",
  date_time: DateTime.new(2025, 11, 15, 18, 30),
  end_time: DateTime.new(2025, 11, 15, 21, 30),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: german,
  user: user2
)

event_9.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896177/cook_jkviyy.jpg"),
  filename: "cook.jpg",
  content_type: "image/jpeg"
)

# Sofia's events (3 past, 2 future)
event_10 = Event.create!(
  title: "Morning Yoga & Mandarin 🧘‍♀️",
  description: "Start your day with yoga while learning basic Mandarin phrases",
  date_time: DateTime.new(2025, 11, 16, 8, 0),
  end_time: DateTime.new(2025, 11, 16, 9, 30),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: mandarin,
  user: user3
)

event_10.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039829/Yoga_tl4qw0.jpg"),
  filename: "workshop.jpg",
  content_type: "image/jpeg"
)

event_11 = Event.create!(
  title: "Book Club: Portuguese Literature 📚",
  description: "Discuss short stories and practice reading comprehension",
  date_time: DateTime.new(2025, 11, 18, 19, 0),
  end_time: DateTime.new(2025, 11, 18, 21, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: portuguese,
  user: user3
)

event_11.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896188/trivia_of7lho.jpg"),
  filename: "study.jpg",
  content_type: "image/jpeg"
)

event_12 = Event.create!(
  title: "Arabic Calligraphy Workshop ✍️",
  description: "Learn beautiful Arabic script while practicing vocabulary",
  date_time: DateTime.new(2025, 11, 20, 14, 0),
  end_time: DateTime.new(2025, 11, 20, 17, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: arabic,
  user: user3
)

event_12.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896184/study_cmfuvk.jpg"),
  filename: "workshop.jpg",
  content_type: "image/jpeg"
)

event_13 = Event.create!(
  title: "Korean Drama Watch Party 📺",
  description: "Watch popular K-dramas with subtitles and discuss in Korean",
  date_time: DateTime.new(2025, 12, 22, 17, 0),
  end_time: DateTime.new(2025, 12, 22, 20, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: korean,
  user: user3
)

event_13.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039190/Korean_Drama_ebxmyu.png"),
  filename: "movie.jpg",
  content_type: "image/jpeg"
)

event_14 = Event.create!(
  title: "Virtual Language Café ☕",
  description: "Online meetup to practice conversation from home",
  date_time: DateTime.new(2025, 12, 23, 16, 0),
  end_time: DateTime.new(2025, 12, 23, 18, 0),
  location: "Online - Link provided after registration",
  topic: spanish,
  user: user3
)

event_14.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039193/Virtual_Language_Cafe_nstiqk.jpg"),
  filename: "online.jpg",
  content_type: "image/jpeg"
)

# James's events (2 past, 3 future)
event_15 = Event.create!(
  title: "Russian Literature Circle 📖",
  description: "Read and discuss classic Russian short stories",
  date_time: DateTime.new(2025, 11, 17, 15, 0),
  end_time: DateTime.new(2025, 11, 17, 17, 30),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: russian,
  user: user4
)

event_15.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896181/networking_pc6wmq.jpg"),
  filename: "study.jpg",
  content_type: "image/jpeg"
)

event_16 = Event.create!(
  title: "Italian Wine & Words 🍷",
  description: "Wine tasting paired with Italian conversation practice",
  date_time: DateTime.new(2025, 11, 21, 19, 0),
  end_time: DateTime.new(2025, 11, 21, 22, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: italian,
  user: user4
)

event_16.image.attach(
  io: URI.open("https://res.cloudinary.com/dvlacvo0z/image/upload/v1764896188/trivia_of7lho.jpg"),
  filename: "cafe.jpg",
  content_type: "image/jpeg"
)

event_17 = Event.create!(
  title: "Travel Stories Exchange 🌍",
  description: "Share travel experiences in your target language",
  date_time: DateTime.new(2025, 12, 24, 14, 0),
  end_time: DateTime.new(2025, 12, 24, 16, 30),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: english,
  user: user4
)

event_17.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039200/Travel_Stories_Exchange_j86tis.jpg"),
  filename: "cafe.jpg",
  content_type: "image/jpeg"
)

event_18 = Event.create!(
  title: "French Pronunciation Workshop 🗣",
  description: "Master difficult French sounds and accent patterns",
  date_time: DateTime.new(2025, 12, 26, 10, 0),
  end_time: DateTime.new(2025, 12, 26, 12, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: french,
  user: user4
)

event_18.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039175/French_Pronunciation_Workshop_fqwu3e.jpg"),
  filename: "workshop.jpg",
  content_type: "image/jpeg"
)

event_19 = Event.create!(
  title: "Polish Conversation Circle 💬",
  description: "Practice Polish in small groups with native speakers",
  date_time: DateTime.new(2025, 12, 27, 18, 0),
  end_time: DateTime.new(2025, 12, 27, 20, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: polish,
  user: user4
)

event_19.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039190/Polish_Conversation_Circle_wctods.jpg"),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

# Marcus's additional future event
event_20 = Event.create!(
  title: "Language Games Tournament 🎮",
  description: "Compete in language-based games and puzzles",
  date_time: DateTime.new(2025, 12, 28, 15, 0),
  end_time: DateTime.new(2025, 12, 28, 18, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: japanese,
  user: user2
)

event_20.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039191/Language_Games_hx3bna.jpg"),
  filename: "game.jpg",
  content_type: "image/jpeg"
)

event_21 = Event.create!(
  title: "Le Wagon Demo Day",
  description: "Join us for Le Wagon's Demo Day showcase! Watch our students present their final projects and celebrate their coding journey. Network with developers, entrepreneurs, and tech enthusiasts. Capacity: 150 attendees.",
  date_time: Time.zone.local(2025, 12, 12, 17, 0),
  end_time: Time.zone.local(2025, 12, 12, 20, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: english,
  user: user2
)

event_21.image.attach(
  io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765039192/Le_Wagon_Demo_Day_ryypfz.jpg"),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

# --- ADDITIONAL FEEDBACKS (for events 9-16) ---
puts "Creating additional feedbacks..."

# Feedbacks for Event 9 (past event)
Feedback.create!(
  user: user,
  event: event_9,
  rating: 5,
  comment: "The cultural exchange dinner was amazing! Learning German while trying authentic dishes from different cultures was a unique experience."
)

Feedback.create!(
  user: user3,
  event: event_9,
  rating: 5,
  comment: "Marcus created such a warm and welcoming atmosphere. The food was delicious and the conversations flowed naturally. Highly recommend!"
)

Feedback.create!(
  user: user4,
  event: event_9,
  rating: 4,
  comment: "Great event! The variety of dishes was impressive. Would have loved more structured conversation activities, but overall very enjoyable."
)

Feedback.create!(
  user: user6,
  event: event_9,
  rating: 5,
  comment: "Perfect blend of culture and language learning. Made some great connections and improved my German significantly!"
)

# Feedbacks for Event 10 (past event)
Feedback.create!(
  user: user,
  event: event_10,
  rating: 4,
  comment: "Combining yoga with Mandarin learning was brilliant! The relaxed atmosphere made it easier to practice pronunciation."
)

Feedback.create!(
  user: user2,
  event: event_10,
  rating: 5,
  comment: "Sofia's yoga and language combination is genius! Started my day feeling energized and learned so much Mandarin vocabulary."
)

Feedback.create!(
  user: user5,
  event: event_10,
  rating: 5,
  comment: "Never thought I'd learn a language through yoga, but it really works! The mindfulness helped with tone pronunciation."
)

# Feedbacks for Event 11 (past event)
Feedback.create!(
  user: user,
  event: event_11,
  rating: 5,
  comment: "The book selection was perfect for our level. Great discussions and improved my Portuguese reading comprehension significantly!"
)

Feedback.create!(
  user: user2,
  event: event_11,
  rating: 4,
  comment: "Really enjoyed analyzing the short stories. Sofia facilitated the discussion wonderfully. Looking forward to the next book club!"
)

Feedback.create!(
  user: user4,
  event: event_11,
  rating: 5,
  comment: "The best way to learn Portuguese literature! The cozy bookstore atmosphere and passionate discussions made this unforgettable."
)

Feedback.create!(
  user: user6,
  event: event_11,
  rating: 5,
  comment: "Sofia's expertise in Portuguese literature really showed. Learned so much about both language and culture. Highly recommend!"
)

# Feedbacks for Event 12 (past event)
Feedback.create!(
  user: user,
  event: event_12,
  rating: 5,
  comment: "Learning Arabic through calligraphy was an incredible experience! The visual connection really helped with memorizing vocabulary."
)

Feedback.create!(
  user: user2,
  event: event_12,
  rating: 5,
  comment: "Sofia is an excellent teacher! The workshop was well-structured and I left with beautiful calligraphy pieces and new Arabic skills."
)

Feedback.create!(
  user: user4,
  event: event_12,
  rating: 4,
  comment: "Challenging but rewarding! The calligraphy aspect made learning Arabic script much more engaging than traditional methods."
)

# Feedbacks for Event 15 (past event)
Feedback.create!(
  user: user,
  event: event_15,
  rating: 5,
  comment: "James's knowledge of Russian literature is impressive! The short stories were captivating and the discussions deepened my understanding."
)

Feedback.create!(
  user: user2,
  event: event_15,
  rating: 5,
  comment: "Loved every minute! Reading classic Russian literature in a group setting made it so much more enjoyable and easier to understand."
)

Feedback.create!(
  user: user3,
  event: event_15,
  rating: 4,
  comment: "Great selection of stories and excellent facilitation by James. My Russian reading skills improved noticeably after this session."
)

# Feedbacks for Event 16 (past event)
Feedback.create!(
  user: user,
  event: event_16,
  rating: 5,
  comment: "Wine and Italian conversation - what could be better? James created a sophisticated yet fun atmosphere for learning."
)

Feedback.create!(
  user: user2,
  event: event_16,
  rating: 4,
  comment: "The wine selection paired perfectly with our Italian lessons! A creative and enjoyable way to practice the language."
)

Feedback.create!(
  user: user3,
  event: event_16,
  rating: 5,
  comment: "Absolutely loved this event! Learned Italian wine vocabulary and had engaging conversations. James is a fantastic organizer!"
)

Feedback.create!(
  user: user6,
  event: event_16,
  rating: 5,
  comment: "The perfect evening! Great wines, great company, and meaningful Italian practice. Can't wait for the next wine and words event!"
)

# --- ADDITIONAL CONFIRMATIONS (for events 6-20) ---
puts "Creating additional confirmations..."

# Event 6 attendees (future)
Confirmation.create!(user: user2, event: event_6)
Confirmation.create!(user: user3, event: event_6)
Confirmation.create!(user: user4, event: event_6)
Confirmation.create!(user: user5, event: event_6)

# Event 7 attendees (future)
Confirmation.create!(user: user2, event: event_7)
Confirmation.create!(user: user3, event: event_7)
Confirmation.create!(user: user4, event: event_7)
Confirmation.create!(user: user6, event: event_7)
Confirmation.create!(user: user5, event: event_7)

# Event 8 attendees (future)
Confirmation.create!(user: user, event: event_8)
Confirmation.create!(user: user3, event: event_8)
Confirmation.create!(user: user4, event: event_8)
Confirmation.create!(user: user5, event: event_8)

# Event 9 attendees (past)
Confirmation.create!(user: user, event: event_9)
Confirmation.create!(user: user3, event: event_9)
Confirmation.create!(user: user4, event: event_9)
Confirmation.create!(user: user5, event: event_9)
Confirmation.create!(user: user6, event: event_9)

# Event 10 attendees (past)
Confirmation.create!(user: user, event: event_10)
Confirmation.create!(user: user2, event: event_10)
Confirmation.create!(user: user4, event: event_10)
Confirmation.create!(user: user5, event: event_10)

# Event 11 attendees (past)
Confirmation.create!(user: user, event: event_11)
Confirmation.create!(user: user2, event: event_11)
Confirmation.create!(user: user4, event: event_11)
Confirmation.create!(user: user5, event: event_11)
Confirmation.create!(user: user6, event: event_11)

# Event 12 attendees (past)
Confirmation.create!(user: user, event: event_12)
Confirmation.create!(user: user2, event: event_12)
Confirmation.create!(user: user4, event: event_12)
Confirmation.create!(user: user5, event: event_12)

# Event 13 attendees (future)
Confirmation.create!(user: user, event: event_13)
Confirmation.create!(user: user2, event: event_13)
Confirmation.create!(user: user4, event: event_13)
Confirmation.create!(user: user5, event: event_13)

# Event 14 attendees (future)
Confirmation.create!(user: user, event: event_14)
Confirmation.create!(user: user2, event: event_14)
Confirmation.create!(user: user4, event: event_14)
Confirmation.create!(user: user6, event: event_14)
Confirmation.create!(user: user5, event: event_14)

# Event 15 attendees (past)
Confirmation.create!(user: user, event: event_15)
Confirmation.create!(user: user2, event: event_15)
Confirmation.create!(user: user3, event: event_15)
Confirmation.create!(user: user5, event: event_15)

# Event 16 attendees (past)
Confirmation.create!(user: user, event: event_16)
Confirmation.create!(user: user2, event: event_16)
Confirmation.create!(user: user3, event: event_16)
Confirmation.create!(user: user5, event: event_16)
Confirmation.create!(user: user6, event: event_16)

# Event 17 attendees (future)
Confirmation.create!(user: user, event: event_17)
Confirmation.create!(user: user2, event: event_17)
Confirmation.create!(user: user3, event: event_17)
Confirmation.create!(user: user5, event: event_17)

# Event 18 attendees (future)
Confirmation.create!(user: user, event: event_18)
Confirmation.create!(user: user2, event: event_18)
Confirmation.create!(user: user3, event: event_18)
Confirmation.create!(user: user5, event: event_18)
Confirmation.create!(user: user6, event: event_18)

# Event 19 attendees (future)
Confirmation.create!(user: user, event: event_19)
Confirmation.create!(user: user2, event: event_19)
Confirmation.create!(user: user3, event: event_19)
Confirmation.create!(user: user5, event: event_19)

# Event 20 attendees (future)
Confirmation.create!(user: user, event: event_20)
Confirmation.create!(user: user3, event: event_20)
Confirmation.create!(user: user5, event: event_20)
Confirmation.create!(user: user6, event: event_20)

# Event 21 attendees (Le Wagon Demo Day - future)
Confirmation.create!(user: user, event: event_21)
Confirmation.create!(user: user3, event: event_21)
Confirmation.create!(user: user4, event: event_21)
Confirmation.create!(user: user5, event: event_21)
Confirmation.create!(user: user6, event: event_21)
Confirmation.create!(user: user7, event: event_21)

# Chat 4: Le Wagon Demo Day (English)
chat_4 = event_21.chat
Message.create!(user: user3, chat: chat_4, content: "Hey everyone! So excited for Demo Day! Has anyone seen the project lineup yet?", ai: false)
Message.create!(user: user4, chat: chat_4, content: "Yes! I heard there are at least 3 AI-powered apps being presented. Should be really interesting!", ai: false)
Message.create!(user: user5, chat: chat_4, content: "Anyone know what time we should actually arrive? It says 5pm but I don't want to miss anything", ai: false)
Message.create!(user: user6, chat: chat_4, content: "I'd get there around 4:45pm to get good seats. Last demo day filled up fast!", ai: false)
Message.create!(user: user7, chat: chat_4, content: "First time attending one of these... I'm honestly a bit nervous 😅 What should I expect?", ai: false)
Message.create!(user: user3, chat: chat_4, content: "Don't worry! It's super chill and everyone's really welcoming. The projects are always impressive though!", ai: false)
Message.create!(user: user2, chat: chat_4, content: "Sherliene, you'll love it! The students are so passionate about their projects. Plus there's usually food and drinks 🍕", ai: false)
Message.create!(user: user4, chat: chat_4, content: "Speaking of which... should we coordinate on snacks? I can grab some coffee from the place next door", ai: false)
Message.create!(user: user5, chat: chat_4, content: "Ooh yes! I'll bring some pastries if you handle coffee. We can meet outside at 4:40?", ai: false)
Message.create!(user: user7, chat: chat_4, content: "You guys are the best! I feel so much better now. I'll help set up if you need an extra pair of hands", ai: false)
Message.create!(user: user6, chat: chat_4, content: "That's the spirit! Has anyone figured out which batch this is? I think it's batch #1024 or something?", ai: false)
Message.create!(user: user3, chat: chat_4, content: "It's batch #1028! I've been following some of them on LinkedIn. The quality of projects this time looks insane", ai: false)
Message.create!(user: user4, chat: chat_4, content: "I know right? I saw a preview of the AI travel planner app. The UI is gorgeous!", ai: false)
Message.create!(user: user2, chat: chat_4, content: "Wait, there's an AI travel planner? That's exactly what I've been looking for! Anyone know if they're planning to launch it?", ai: false)
Message.create!(user: user5, chat: chat_4, content: "Not sure, but I heard you can talk to the teams after presentations. Great networking opportunity!", ai: false)
Message.create!(user: user6, chat: chat_4, content: "Pro tip: bring business cards if you have them. I got a freelance gig from the last demo day 💼", ai: false)
Message.create!(user: user7, chat: chat_4, content: "Wow really? That's amazing! I should probably prepare some questions then", ai: false)
Message.create!(user: user3, chat: chat_4, content: "Just be yourself! The students love genuine interest in their work. They're usually happy to explain everything", ai: false)
Message.create!(user: user4, chat: chat_4, content: "So final plan: meet at 4:40 outside, Priya brings pastries, I bring coffee, get good seats by 4:50. Sound good?", ai: false)
Message.create!(user: user5, chat: chat_4, content: "Perfect! I'm so pumped for this. See you all Thursday! 🚀", ai: false)
Message.create!(user: user2, chat: chat_4, content: "Can't wait! This is going to be epic. Thanks everyone for organizing!", ai: false)

# Additional personas for Le Wagon Demo Day
# Creating users for Le Wagon staff and team members
rachel = User.create!(
  name: "Rachel",
  email: "rachel@lewagon.com",
  password: "password"
)

antoine = User.create!(
  name: "Antoine",
  email: "antoine@lewagon.com",
  password: "password"
)

mg = User.create!(
  name: "MG",
  email: "mg@lewagon.com",
  password: "password"
)

nadia = User.create!(
  name: "Nadia",
  email: "nadia@lewagon.com",
  password: "password"
)

enrique = User.create!(
  name: "Enrique",
  email: "enrique@lewagon.com",
  password: "password"
)

# Le Wagon Demo Day chat continues with staff and team interactions
Message.create!(user: rachel, chat: chat_4, content: "Hi everyone! Rachel here, I'll be your MC for tonight's Demo Day! 🎤 So thrilled to see this amazing turnout. We have two incredible teams presenting tonight!", ai: false)
Message.create!(user: antoine, chat: chat_4, content: "Welcome everyone! I'm Antoine, founder of Le Wagon. Tonight we celebrate the culmination of 9 intensive weeks of coding. These teams have poured their hearts into their projects. Prepare to be amazed! 🚀", ai: false)
Message.create!(user: mg, chat: chat_4, content: "Bonjour! MG here from Le Wagon Montreal. I couldn't be prouder of our Montreal batch. The quality of work this cohort has produced is truly world-class! 🇨🇦", ai: false)
Message.create!(user: nadia, chat: chat_4, content: "Hey everyone! Nadia, one of your tutors. I've watched these students grow from coding beginners to building full-stack applications. The dedication has been incredible! Can't wait to see the demos! 💪", ai: false)
Message.create!(user: enrique, chat: chat_4, content: "Enrique here! As a tutor, I've seen the late nights, the debugging sessions, the breakthroughs... these teams have earned this moment. So proud! Let's give them the energy they deserve! 🎉", ai: false)

# Team 1 (FriendFusion) - Flo, Middwin, Pavel
Message.create!(user: user3, chat: chat_4, content: "Hi everyone! Flo from Team 1 here. We're presenting FriendFusion - an app that brings people together through language learning events. Super nervous but excited! 😊", ai: false)
Message.create!(user: user2, chat: chat_4, content: "Middwin here, also Team 1! We've built something really special. FriendFusion uses AI to help people connect and practice languages in real-world settings. Can't wait to show you all!", ai: false)
Message.create!(user: user4, chat: chat_4, content: "Pavel from Team 1 checking in! We've integrated AI chat features that personalize the language learning experience. The tech stack has been challenging but so rewarding! 💻", ai: false)
Message.create!(user: rachel, chat: chat_4, content: "Love the energy Team 1! FriendFusion sounds like exactly what the language learning community needs. Looking forward to your demo!", ai: false)

# Team 2 (ChairHop) - Wanji, Frank, Sherliene
Message.create!(user: user6, chat: chat_4, content: "Wanji here from Team 2! We're presenting ChairHop - making workspace booking seamless for hybrid teams. The past 9 weeks have been a wild ride! 🪑", ai: false)
Message.create!(user: user5, chat: chat_4, content: "Frank, Team 2! ChairHop solves the problem of finding the perfect workspace when you need it. We've integrated real-time availability and smart recommendations! 📍", ai: false)
Message.create!(user: user7, chat: chat_4, content: "Sherliene from Team 2 here! Our design focuses on making the booking experience intuitive and delightful. So excited (and nervous!) to present our work! ✨", ai: false)
Message.create!(user: nadia, chat: chat_4, content: "Team 2, ChairHop is such a relevant solution for today's work environment! The real-time features you've built are technically impressive. Well done! 👏", ai: false)

# Pre-presentation conversations
Message.create!(user: antoine, chat: chat_4, content: "Both teams have identified real problems and built elegant solutions. This is what Le Wagon is all about - empowering people to bring their ideas to life through code! 💡", ai: false)
Message.create!(user: enrique, chat: chat_4, content: "Quick reminder teams - take a deep breath, trust your preparation, and enjoy this moment. You've all earned it! The technical depth you've achieved in 9 weeks is remarkable! 🌟", ai: false)
Message.create!(user: user3, chat: chat_4, content: "Thanks Enrique! Team 1 is ready. We've practiced our demo about 20 times 😅 Flo, Middwin, Pavel - let's do this!", ai: false)
Message.create!(user: user2, chat: chat_4, content: "Let's show them what FriendFusion can do! Our AI chat feature is going to blow their minds. Ready team? 🔥", ai: false)
Message.create!(user: user4, chat: chat_4, content: "Ready! Our live demo environment is stable, database is seeded with great data. Let's crush this presentation! 💪", ai: false)
Message.create!(user: user6, chat: chat_4, content: "Team 2 is pumped! ChairHop is ready to shine. Wanji, Frank, Sherliene - we got this! Let's show them how we're revolutionizing workspace booking! 🚀", ai: false)
Message.create!(user: user5, chat: chat_4, content: "All systems go on our end! The booking flow is smooth, the map integration works perfectly. Time to make Le Wagon proud! 🎯", ai: false)
Message.create!(user: user7, chat: chat_4, content: "The UI looks gorgeous on the big screen. Our user journey is crystal clear. I'm ready! Let's do this Team 2! ✨", ai: false)
Message.create!(user: rachel, chat: chat_4, content: "Alright everyone! We're about to start in 5 minutes. Teams, please make your way to the staging area. Audience, grab your seats! This is going to be an unforgettable evening! 🎭", ai: false)
Message.create!(user: mg, chat: chat_4, content: "To all our guests - you're about to witness the transformation that happens at Le Wagon. These weren't developers 9 weeks ago. Now they're launching startups. This is the magic of our bootcamp! ✨", ai: false)
Message.create!(user: nadia, chat: chat_4, content: "Good luck to both teams! Remember - you know your projects inside and out. Just share your passion and the rest will follow naturally! 🍀", ai: false)
Message.create!(user: antoine, chat: chat_4, content: "Let's give a warm welcome to our presenters! These brave individuals took the leap to change their careers through code. Tonight, they graduate not just as developers, but as entrepreneurs! 👏", ai: false)

# Confirmation for Le Wagon staff
Confirmation.create!(user: rachel, event: event_21)
Confirmation.create!(user: antoine, event: event_21)
Confirmation.create!(user: mg, event: event_21)
Confirmation.create!(user: nadia, event: event_21)
Confirmation.create!(user: enrique, event: event_21)

user.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041673/Ceci_ixrwxv.png"), filename: "ceci.jpg", content_type: "image/jpeg")
user2.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041670/Middwin_xydzch.png"), filename: "middwin.jpg", content_type: "image/jpeg")
user3.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041676/Flo_ljuinv.png"), filename: "flo.jpg", content_type: "image/jpeg")
user4.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041674/Pavel_bgv7ve.png"), filename: "pavel.jpg", content_type: "image/jpeg")
user5.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041673/Frank_k2xxpl.png"), filename: "frank.jpg", content_type: "image/jpeg")
user6.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041670/Wanji_nje50u.png"), filename: "wanji.jpg", content_type: "image/jpeg")
user7.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041671/Sherliene_ipctq8.png"), filename: "sherliene.jpg", content_type: "image/jpeg")
rachel.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041676/Rachel_b9f1em.png"), filename: "rachel.jpg", content_type: "image/jpeg")
antoine.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041671/Antoine_nstc0g.png"), filename: "antoine.jpg", content_type: "image/jpeg")
mg.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041675/MG_lzyudo.png"), filename: "mg.jpg", content_type: "image/jpeg")
nadia.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041677/Nadia_woujaq.png"), filename: "nadia.jpg", content_type: "image/jpeg")
enrique.avatar.attach(io: URI.open("https://res.cloudinary.com/dj2zl0gib/image/upload/v1765041672/Enrique_gfucma.png"), filename: "enrique.jpg", content_type: "image/jpeg")

puts "✅ Database seeded successfully!"
puts "Created #{User.count} users"
puts "Created #{Topic.count} topics"
puts "Created #{Event.count} events"
puts "Created #{Confirmation.count} confirmations"
puts "Created #{Feedback.count} feedbacks"
puts "Created #{Notification.count} notifications"
