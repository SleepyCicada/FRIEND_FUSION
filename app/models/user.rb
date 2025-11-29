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
  # has_many :feedbacks

  validates :name, presence: true
end
