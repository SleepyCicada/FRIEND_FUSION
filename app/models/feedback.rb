class Feedback < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many_attached :pictures

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { minimum: 10, maximum: 5000 }
  validate :acceptable_pictures

  private

  def acceptable_pictures
    return unless pictures.attached?

    pictures.each do |picture|
      unless picture.byte_size <= 5.megabytes
        errors.add(:pictures, "each must be less than 5MB")
      end

      acceptable_types = ["image/jpeg", "image/jpg", "image/png", "image/gif"]
      unless acceptable_types.include?(picture.content_type)
        errors.add(:pictures, "must be a JPEG, PNG, or GIF")
      end
    end
  end
end
