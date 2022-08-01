class CommentsController < ApplicationController
  before_action :set_post

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

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted :('
    redirect_to root_path
  end
end
