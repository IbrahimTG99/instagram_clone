class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  validates :user_id, presence: true
  validates :images, presence: true, length: { minimum: 1 , maximum: 10 }

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
end