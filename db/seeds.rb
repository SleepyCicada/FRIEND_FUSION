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

# TOPIC TABLE
Topic.destroy_all

# USERS LAST
User.destroy_all

puts "Creating test data..."

# --- USERS ---
user = User.create!(
  name: "Anna",
  email: "anna@example.com",
  password: "password"
)

user2 = User.create!(
  name: "Marcus",
  email: "marcus@example.com",
  password: "password"
)

user3 = User.create!(
  name: "Sofia",
  email: "sofia@example.com",
  password: "password"
)

user4 = User.create!(
  name: "James",
  email: "james@example.com",
  password: "password"
)

user5 = User.create!(
  name: "Priya",
  email: "priya@example.com",
  password: "password"
)

user6 = User.create!(
  name: "Chen",
  email: "chen@example.com",
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
  io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/movie.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/game.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/cook.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/networking.jpg")),
  filename: "networking.jpg",
  content_type: "image/jpeg"
)

event_7 = Event.create!(
  title: "Online Conversation Bootcamp 👥",
  description: "Mini debates & interactive prompts in a virtual setting",
  date_time: DateTime.new(2025, 12, 20, 10, 0),
  end_time: DateTime.new(2025, 12, 20, 12, 0),
  location: "5570 Av. Casgrain #101, Montréal, QC H2T 1X9",
  topic: english,
  user: user,
)

event_7.image.attach(
  io: File.open(Rails.root.join("db/seeds/images/online.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/study.jpg")),
  filename: "study.jpg",
  content_type: "image/jpeg"
)

# --- CONFIRMATIONS ---
puts "Creating confirmations..."

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
  comment: "This was my first language meetup and it exceeded all expectations! Anna did a fantastic job organizing everything. The coffee was great too!"
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

# --- CHAT DEMOS WITH MULTI-USER CONVERSATIONS ---

# Chat 1: Coffee & Conversation (English) - Group Discussion
chat_1 = event_1.chat

# Early messages - before Anna joins (important info she'll miss)
Message.create!(user: user2, chat: chat_1, content: "Hey everyone! Super excited for this Coffee & Conversation event on Dec 13th!", ai: false)
Message.create!(user: user3, chat: chat_1, content: "Hi Marcus! Me too! Has anyone been to this cafe before? I heard they have great pastries.", ai: false)
Message.create!(user: user4, chat: chat_1, content: "Yes! I've been there twice. Quick heads up - the cafe location changed! It's now at 142 Main Street, not the old address on the website.", ai: false)
Message.create!(user: user2, chat: chat_1, content: "Oh thanks for letting us know James! That's really important. Should we update the event organizer?", ai: false)
Message.create!(user: user5, chat: chat_1, content: "Hey everyone! First time at one of these events. A bit nervous but excited! Also, James, thanks for the address update!", ai: false)
Message.create!(user: user3, chat: chat_1, content: "Welcome Priya! Don't worry, everyone's super friendly. I've been to 3 of these and they're always great!", ai: false)
Message.create!(user: user6, chat: chat_1, content: "Hi all! I'm coming from the north side. If anyone wants to carpool, I have room for 2 people. DM me!", ai: false)
Message.create!(user: user4, chat: chat_1, content: "That's nice of you Chen! I might take you up on that. Also, FYI the cafe gets busy around 10am, so I suggest we aim to arrive at 9:45am to grab good seats.", ai: false)
Message.create!(user: user2, chat: chat_1, content: "Good thinking! I'll plan to be there at 9:45. Should we have a specific table or meeting spot inside?", ai: false)
Message.create!(user: user5, chat: chat_1, content: "The cafe has a back room with big communal tables. That's probably where we should meet. I'll bring some conversation starter cards I made!", ai: false)
Message.create!(user: user3, chat: chat_1, content: "Oh that's a great idea Priya! I have some English idiom flashcards too. We could use those for practice.", ai: false)
Message.create!(user: user6, chat: chat_1, content: "Perfect! So just to recap: 142 Main Street, arrive by 9:45am, meet in the back room. Priya and Sofia are bringing materials. Anything else?", ai: false)
Message.create!(user: user4, chat: chat_1, content: "I think that covers it! Oh, and I heard they don't take cash, so bring cards only. See you all there!", ai: false)
Message.create!(user: user2, chat: chat_1, content: "No cash, got it. This is going to be fun! Can't wait to practice my conversation skills with you all.", ai: false)
Message.create!(user: user5, chat: chat_1, content: "Same here! I've been working on my pronunciation and could really use the practice. See everyone Friday!", ai: false)
Message.create!(user: user6, chat: chat_1, content: "Looking forward to meeting everyone! I'll create a shared notes doc so we can all add topics we want to discuss.", ai: false)

# Anna joins late and missed all the important info
Message.create!(user: user, chat: chat_1, content: "Hi everyone! Sorry I'm late joining the chat. Looking forward to this event!", ai: false)

# Chat 2: Cooking & Conversation Class (Italian)
chat_2 = event_4.chat
Message.create!(user: user, chat: chat_2, content: "Ciao! Excited for this cooking class!", ai: false)
Message.create!(user: nil, chat: chat_2, content: "Ciao! Benvenuto! 🇮🇹 I can help you prepare Italian cooking vocabulary. What would you like to learn?", ai: true)
Message.create!(user: user, chat: chat_2, content: "I want to make pasta from scratch but don't know the Italian terms. Can you help?", ai: false)
Message.create!(user: nil, chat: chat_2, content: "Perfetto! Here are essential pasta-making terms:\n\n**Ingredients:**\n• farina (flour)\n• uova (eggs)\n• sale (salt)\n• acqua (water)\n\n**Actions:**\n• impastare (to knead)\n• stendere (to roll out)\n• tagliare (to cut)\n• cuocere (to cook)\n\n**Pasta types:**\n• tagliatelle, fettuccine, pappardelle\n\nWould you like a simple recipe in Italian?", ai: true)
Message.create!(user: user, chat: chat_2, content: "Yes please! A simple one for beginners.", ai: false)
Message.create!(user: nil, chat: chat_2, content: "Ecco una ricetta semplice! (Here's a simple recipe!)\n\n**Pasta Fresca Semplice:**\n1. Mescola 200g di farina con 2 uova (Mix 200g flour with 2 eggs)\n2. Impasta per 10 minuti (Knead for 10 minutes)\n3. Lascia riposare 30 minuti (Let rest 30 minutes)\n4. Stendi e taglia (Roll out and cut)\n5. Cuoci in acqua bollente per 3 minuti (Cook in boiling water for 3 minutes)\n\nBuon appetito! 👨‍🍳", ai: true)

# Chat 3: Survival Workshop (Japanese)
chat_3 = event_5.chat
Message.create!(user: user, chat: chat_3, content: "Hello! I'm traveling to Japan next month and need emergency phrases.", ai: false)
Message.create!(user: nil, chat: chat_3, content: "こんにちは! I'll help you with essential emergency phrases for Japan. What situations concern you most?", ai: true)
Message.create!(user: user, chat: chat_3, content: "Medical emergencies and asking for help. Also getting lost!", ai: false)
Message.create!(user: nil, chat: chat_3, content: "Important phrases for emergencies:\n\n**Medical:**\n• 助けてください！(Tasukete kudasai!) - Help!\n• 病院はどこですか？(Byōin wa doko desu ka?) - Where is the hospital?\n• 救急車を呼んでください (Kyūkyūsha o yonde kudasai) - Please call an ambulance\n• 英語を話せる人はいますか？(Eigo o hanaseru hito wa imasu ka?) - Is there anyone who speaks English?\n\n**Getting Lost:**\n• 道に迷いました (Michi ni mayoimashita) - I'm lost\n• ここはどこですか？(Koko wa doko desu ka?) - Where am I?\n• [Place name]へ行きたいです ([Place] e ikitai desu) - I want to go to [place]\n\nWrite these down and practice them!", ai: true)
Message.create!(user: user, chat: chat_3, content: "Perfect! What about basic courtesy phrases I should know?", ai: false)
Message.create!(user: nil, chat: chat_3, content: "Essential courtesy phrases:\n\n• すみません (Sumimasen) - Excuse me/Sorry (most versatile!)\n• ありがとうございます (Arigatō gozaimasu) - Thank you\n• ごめんなさい (Gomen nasai) - I'm sorry\n• お願いします (Onegaishimasu) - Please/I ask of you\n• 分かりません (Wakarimasen) - I don't understand\n\nJapanese people appreciate effort! Don't worry about perfect pronunciation—they'll help you. 🇯🇵\n\nSee you at the workshop!", ai: true)

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
  io: File.open(Rails.root.join("db/seeds/images/cook.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/study.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/movie.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/online.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/study.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/cafe.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/workshop.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/networking.jpg")),
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
  io: File.open(Rails.root.join("db/seeds/images/game.jpg")),
  filename: "game.jpg",
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

puts "✅ Database seeded successfully!"
puts "Created #{User.count} users"
puts "Created #{Topic.count} topics"
puts "Created #{Event.count} events"
puts "Created #{Confirmation.count} confirmations"
puts "Created #{Feedback.count} feedbacks"
