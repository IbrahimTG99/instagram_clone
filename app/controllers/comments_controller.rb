class CommentsController < ApplicationController
  before_action :set_post, only: %i[create]
  before_action :set_comment, only: %i[edit destroy update]
  before_action :ensure_user_is_owner, only: %i[edit destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?

    if @comment.save
      flash[:success] = 'You commented on that post!'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Check the comment form, something went wrong.'
      render root_path
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = 'Something worng, try again'
      render root_path
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted :('
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
