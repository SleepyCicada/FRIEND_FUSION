class AiChat < ApplicationRecord
  belongs_to :user
  has_many :ai_messages
end
