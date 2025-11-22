class Event < ApplicationRecord
  belongs_to :topic
  has_many :feedbacks
  has_many :confirmations
  has_one :chat
  has_many :users, through: :confirmations
  has_one_attached :image
  belongs_to :user
  after_create :schedule_reminder
  private

  def schedule_reminder
    reminder_time = start_time - 1.day
    EventReminderJob.set(wait_until: reminder_time).perform_later(self.id)
  end
end
