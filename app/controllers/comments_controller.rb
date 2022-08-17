class CommentsController < ApplicationController
  before_action :set_post, only: %i[create]
  before_action :set_comment, only: %i[edit destroy update]

  def create
    authorize Comment
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    authorize @comment
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = 'Something worng, try again'
      render root_path
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def ensure_user_is_owner
    return true if @comment.user == current_user
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
