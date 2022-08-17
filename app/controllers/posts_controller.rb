class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  def index
    redirect_to root_path
  end

  def create
    authorize Post
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path, flash: { success: 'Post created!' }
    else
      render :new, flash: { danger: 'Post not created!' }
    end
  end

  def new
    @post = Post.new
  end

  def show; end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to root_path, flash: { success: 'Post updated!' }
    else
      redirect_to edit_post_path, flash: { danger: 'Post not updated!' }
    end
  end

  def destroy
    authorize @post
    @post.images.each(&:purge)
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
