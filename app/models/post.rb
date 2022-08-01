class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  validates :image, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # yet to be implemented
  has_many :images, dependent: :destroy
  # defining scope using lamba function that returns followed users posts
  scope :of_followed_users, ->(following_users) { where user_id: following_users }

  has_attached_file :image, styles: { medium: '640x' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  def total_likes
    likes.count
  end
end
