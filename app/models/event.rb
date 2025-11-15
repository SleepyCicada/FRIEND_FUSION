class Event < ApplicationRecord
  has_many :feedbacks, :confirmations
  has_one :chat
  has_many :users, through: :confirmations
end
