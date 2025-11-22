class Topic < ApplicationRecord
  has_many :events, dependent: :destroy
end
