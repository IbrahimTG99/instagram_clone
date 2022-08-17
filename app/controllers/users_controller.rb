class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:profile]
  def index
    @posts = Post.all
  end

  def profile
    # show user profile
    @posts = @user.posts
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
