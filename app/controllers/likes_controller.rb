class LikesController < ApplicationController
  def create
    @post_id = params[:post_id]
    like_exists = Like.find_or_initialize_by(user_id: current_user.id, post_id: @post_id)
    respond_to do |format|
      format.js do
        @success = if like_exists.persisted?
                     like_exists.destroy
                     false
                   else
                     like_exists.save ? true : false
                   end
        update_view
      end
    end
  end

  private

  def update_view
    @post_likes = Post.find(@post_id).likes_count
    render 'posts/like'
  end
end
