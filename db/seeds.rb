Message.destroy_all
Chat.destroy_all
Topic.destroy_all
Event.destroy_all
AiChat.destroy_all
AiMessage.destroy_all
User.destroy_all

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
