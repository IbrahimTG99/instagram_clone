class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  def create
    @post = Post.create(post_params)
    @post.user = current_user if user_signed_in?
    if @post.save
      redirect_to root_path, flash: { success: 'Post created!' }
    else
      redirect_to new_post_path, flash: { error: 'Post not created!' }
    end
  end

  def new
    @post = Post.new
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to root_path, flash: { success: 'Post updated!' }
    else
      redirect_to edit_post_path, flash: { error: 'Post not updated!' }
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, flash: { success: 'Post deleted!' }
  end

  private

  def set_post
    @post = Post.find(params[:id]) if params[:id].present?
  end

  def post_params
    params.require(:post).permit(:caption, images: [])
  end
end