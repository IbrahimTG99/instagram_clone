class Post < ApplicationRecord
  default_scope { order created_at: :desc }
  validates :image, presence: true
  belongs_to :user
  has_many :likes

  has_attached_file :image, styles: { medium: '640x' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  def total_likes
    likes.count
  end
end
