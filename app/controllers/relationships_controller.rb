class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find_by! username: params[:username]
    return unless current_user.follow @user.id

    respond_to do |format|
      format.js do
        format.html { redirect_to root_path }
        @follower_count = @user.follower_count
        render 'users/follow_user'
      end
    end
  end

  def unfollow_user
    @user = User.find_by! username: params[:username]
    return unless current_user.unfollow @user.id

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js do
        @follower_count = @user.follower_count
        render 'users/unfollow_user'
      end
    end
  end
end
