class UsersController < ApplicationController
  before_action :set_user, only: %i[profile destroy]
  def index
    load_index
    load_suggestions
  end

  def profile
    @posts = @user.posts
  end

  def search
    @find = User.text_search(params[:q])
    render json: @find
  end

  def destroy
    ActiveRecord::Base.transaction do
      @user.destroy
      @user.comments.destroy_all
      @user.likes.destroy_all
      @user.posts.each(&:purge)
      redirect_to root_path, flash: { success: 'User deleted!' }
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def load_index
    @posts = Post.of_followed_users(current_user.following + [current_user])
    @stories = Story.of_followed_users(current_user.following + [current_user])
  end

  def load_suggestions
    following_ids = current_user.following_relationships.pluck(:following_id)
    @follower_suggestions = User.where.not(id: following_ids).limit(4) - [current_user]
    @pending_follows = current_user.follower_relationships.where(status: 'pending')
  end
end
