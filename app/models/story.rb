class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :image, presence: true
  scope :of_followed_users, ->(following_users) { where user_id: following_users }
  validate :image_format

  private

  def image_format
    errors.add(:image, 'missing') unless image.attached?

    errors.add(:image, 'must be a JPEG or PNG') unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
  end
end
