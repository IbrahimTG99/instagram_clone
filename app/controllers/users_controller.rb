class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def show; end
end
