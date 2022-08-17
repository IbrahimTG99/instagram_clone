class LikesController < ApplicationController
  def create
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    @post_id = params[:post_id]
    like_exists = Like.where(post_id: @post_id, user_id: current_user.id)
    respond_to do |format|
      format.js do
        if like_exists.exists?
          like_exists.first.destroy
          @success = false
        else
          @success = @like.save ? true : false
        end
        @post_likes = Post.find(@post_id).likes_count
        render 'posts/like'
      end
    end
  end
end
