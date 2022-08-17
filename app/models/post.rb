class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  validates :user_id, presence: true
  validates :images, presence: true
  validate :images_format

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  # defining scope using lamba function that returns followed users posts
  scope :of_followed_users, ->(following_users) { where user_id: following_users }

  private

  def images_format
    return unless images.attached?

    images.each do |image|
      errors.add(:images, 'must be a JPEG or PNG') unless image.content_type.in?(%w[image/jpeg image/png image/jpg])
    end
  end
end
