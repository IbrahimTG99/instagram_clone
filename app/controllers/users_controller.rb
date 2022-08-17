class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:profile]
  def index
    load_index
    load_suggestions
  end

  def profile
    # show user profile
    @posts = @user.posts
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def search_user
    @find = User.text_search(params[:q])
    render json: @find
  end

  private

  def load_index
    # posts and stories of followed users
    @posts = Post.of_followed_users(current_user.following + [current_user])
    @stories = Story.of_followed_users(current_user.following + [current_user])
  end

  def load_suggestions
    following_ids = current_user.following_relationships.pluck(:following_id)
    @follower_suggestions = User.where.not(id: following_ids).limit(4) - [current_user]
    # pending follows relationship where status false and current_user is not the follower
    @pending_follows = current_user.follower_relationships.where(status: 'pending')
  end
end
