class Event < ApplicationRecord
  has_many :feedbacks
  has_many :confirmations
  has_one :chat
  has_many :users, through: :confirmations
  has_one_attached :image
end
