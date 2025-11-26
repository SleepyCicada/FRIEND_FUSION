class Event < ApplicationRecord
  belongs_to :topic
  has_many :feedbacks
  has_many :confirmations
  has_one :chat
  has_many :users, through: :confirmations
  has_one_attached :image
  belongs_to :user
  after_create :schedule_reminder
  after_create :create_event_chat
  validates :date_time, presence: true
  validates :title, presence: true
  validates :topic, presence: true

  private
  def schedule_reminder
    return unless date_time && date_time > Time.current

    reminder_time = date_time - 1.day
    EventReminderJob.set(wait_until: reminder_time).perform_later(self.id)
  end

  def create_event_chat
    # Ensure every event has a chat
    Chat.find_or_create_by(event: self)
  end
end
