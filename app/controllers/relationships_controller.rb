class RelationshipsController < ApplicationController
  def follow_user
    @user = User.find_by! username: params[:username]
    return unless current_user.follow @user.id

    respond_to do |format|
      format.js do
        format.html { redirect_to root_path }
        @follower_count = @user.follower_count
        # check if user has a private account
        if @user.private
          render 'users/pending_follow'
        else
          render 'users/follow_user'
        end
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

  def accept_follow
    @user = User.find_by! username: params[:username]
    @relationship = current_user.follower_relationships.find_by! follower_id: @user.id
    @relationship.update(status: 'accepted')
    respond_to do |format|
      format.js do
        format.html { redirect_to root_path }
        render 'users/accept_follow'
      end
    end
  end

  def reject_follow
    @user = User.find_by! username: params[:username]
    @relationship = current_user.follower_relationships.find_by! follower_id: @user.id
    @relationship.destroy
    respond_to do |format|
      format.js do
        format.html { redirect_to root_path }
        render 'users/reject_follow'
      end
    end
  end
end
