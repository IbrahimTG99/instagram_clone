class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:profile]
  def index
    # @posts = Post.all
    # posts of followed users
    @posts = Post.of_followed_users(current_user.following + [current_user])
    following_ids = current_user.following.map(&:id)
    @follower_suggestions = User.where.not(id: following_ids).limit(4) - [current_user]
    @stories = Story.all
  end

  def profile
    # show user profile
    @posts = @user.posts
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def search_user
    @find = User.where('username LIKE ?', "%#{params[:q]}%")
    render json: @find
  end
end
