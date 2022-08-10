class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_comments_count
  after_destroy :decrement_comments_count

  validates :content, presence: true

  private

  def increment_comments_count
    Post.find(post_id).increment(:comments_count).save
  end

  def decrement_comments_count
    Post.find(post_id).decrement(:comments_count).save
  end
end
