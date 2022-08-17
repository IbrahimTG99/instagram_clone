class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, uniqueness: { scope: :user_id }

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  private

  def increment_likes_count
    post.increment(:likes_count).save
  end

  def decrement_likes_count
    post.decrement(:likes_count).save
  end
end
