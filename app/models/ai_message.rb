class AiMessage < ApplicationRecord
  belongs_to :ai_chat
  belongs_to :user, optional: true
end
