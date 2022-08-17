module UsersHelper
  def can_edit_profile?(profile_id)
    user_signed_in? && current_user.id == profile_id
  end

  def can_edit_post?(post_id)
    user_signed_in? && current_user.posts.include?(Post.find(post_id))
  end

  def can_edit_comment?(comment_id)
    user_signed_in? && current_user.comments.include?(Comment.find(comment_id))
  end

  def can_edit_story?(story_id)
    user_signed_in? && current_user.stories.include?(Story.find(story_id))
  end

  delegate :following?, to: :current_user
end
