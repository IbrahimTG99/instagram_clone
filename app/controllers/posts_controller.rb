class PostsController < ApplicationController
  def create
    @post = Post.create(post_params)
    @post.user = current_user if user_signed_in?
    if @post.save
      redirect_to dashboard_path, flash: { success: 'Post created!' }
    else
      redirect_to new_post_path, flash: { error: 'Post not created!' }
    end
  end

  def new
    @post = Post.new
  end

  def show; end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
