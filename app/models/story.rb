class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :audio
  has_one_attached :cover_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :language, :category, presence: true

  validate :cover_image_format

def cover_image_format
  return unless cover_image.attached?
  if !cover_image.content_type.in?(%w[image/jpeg image/png])
    errors.add(:cover_image, "must be a JPG or PNG file")
  end
end

end
