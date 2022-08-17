class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, uniqueness: { scope: :user_id }

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  private

  def increment_likes_count
    Post.find(post_id).increment(:likes_count).save
  end

  def decrement_likes_count
    Post.find(post_id).decrement(:likes_count).save
  end
end
