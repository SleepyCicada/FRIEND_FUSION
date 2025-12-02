class Event < ApplicationRecord
  belongs_to :topic
  has_many :feedbacks, dependent: :destroy
  has_many :confirmations, dependent: :destroy
  has_one :chat, dependent: :destroy
  has_many :users, through: :confirmations
  has_one_attached :image
  belongs_to :user, optional: true
  after_create :schedule_reminder
  after_create :create_event_chat
  validates :date_time, presence: true
  validates :title, presence: true
  validates :topic, presence: true
  validates :location, presence: true, length: { minimum: 3, maximum: 255 }
  validates :description, length: { minimum: 10, maximum: 5000 }, allow_blank: true
  validates :max_capacity, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validate :end_time_after_start_time
  geocoded_by :location
  after_validation :geocode, if: :should_geocode?

  def event_ended?
    return false unless end_time.present?
    end_time < Time.current
  end

  def average_rating
    return 0 if feedbacks.empty?
    (feedbacks.average(:rating).to_f).round(1)
  end

  def feedback_count
    feedbacks.count
  end

  private

  def should_geocode?
    # Only geocode in production to avoid SSL issues during seeding/testing
    will_save_change_to_location? && Rails.env.production?
  end

  def end_time_after_start_time
    return if end_time.blank? || date_time.blank?

    if end_time <= date_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def schedule_reminder
    return unless date_time && date_time > Time.current

    reminder_time = date_time - 1.day
    EventReminderJob.set(wait_until: reminder_time).perform_later(id)
  end

  def create_event_chat
    # Ensure every event has a chat
    Chat.find_or_create_by(event: self)
  end
end
