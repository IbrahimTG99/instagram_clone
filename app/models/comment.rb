class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create :increment_comments_count
  after_destroy :decrement_comments_count


  private

  def increment_comments_count
    Post.find(post_id).increment(:comments_count).save
  end

  def decrement_comments_count
    Post.find(post_id).decrement(:comments_count).save
  end
end
