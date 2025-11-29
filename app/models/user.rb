class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :confirmations
  has_many :ai_chats
  has_many :messages
  has_many :notifications
  has_many :ai_messages
  has_many :events, through: :confirmations
  has_many :organized_events, class_name: "Event", foreign_key: "user_id"
  has_many :feedbacks

  validates :name, presence: true

  # Organizer statistics
  def average_organizer_rating
    feedbacks_for_events = Feedback.joins(:event).where(events: { user_id: id })
    return 0 if feedbacks_for_events.empty?
    (feedbacks_for_events.average(:rating).to_f).round(1)
  end

  def total_attendees_hosted
    Confirmation.joins(:event).where(events: { user_id: id }).count
  end

  def events_organized_count
    organized_events.count
  end
end
