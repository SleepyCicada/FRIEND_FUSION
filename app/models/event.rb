class Event < ApplicationRecord
  belongs_to :topic, optional: true
  has_many :feedbacks
  has_many :confirmations
  has_one :chat
  has_many :users, through: :confirmations
  has_one_attached :image
  belongs_to :user, optional: true
  after_create :schedule_reminder
  validates :date_time, presence: true
  validates :title, presence: true

  private

  def schedule_reminder
    return unless date_time && date_time > Time.current

    reminder_time = date_time - 1.day
    EventReminderJob.set(wait_until: reminder_time).perform_later(id)
  end
end
