class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  validates :image, presence: true
  validate :image_format

  private

  def image_format
    unless image.content_type.in?(%w[image/jpeg image/png image/gif image/jpg])
      errors.add(:image, 'must be a JPEG or PNG')
    end
  end
end
