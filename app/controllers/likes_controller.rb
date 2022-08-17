class LikesController < ApplicationController
  def create
    @post_id = params[:post_id]
    like_exists = Like.where(post_id: @post_id, user_id: current_user.id)
    respond_to do |format|
      format.js do
        if like_exists.exists?
          like_exists.first.destroy
          @success = false
        else
          @like = Like.new(post_id: @post_id, user_id: current_user.id)
          @success = @like.save ? true : false
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
