class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  validates :user_id, presence: true
  validates :images, presence: true
  validate :images_format

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # yet to be implemented
  has_many_attached :images, dependent: :destroy
  # defining scope using lamba function that returns followed users posts
  scope :of_followed_users, ->(following_users) { where user_id: following_users }

  def total_likes
    likes.count
  end

  private

  def images_format
    return if images.attached?

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/gif image/jpg])
        errors.add(:images, 'must be a JPEG or PNG')
      end
    end
  end
end
