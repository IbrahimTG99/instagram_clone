class RelationshipsController < ApplicationController
  before_action :set_user
  def follow_user
    return unless current_user.follow @user.id

    respond_to do |format|
      format.js do
        format.html { redirect_to root_path }
        @follower_count = @user.follower_count
<<<<<<< Updated upstream
        render 'users/follow_user'
=======
        if @user.private?
          render 'users/pending_follow'
        else
          render 'users/follow_user'
        end
>>>>>>> Stashed changes
      end
    end
  end

  def unfollow_user
    return unless current_user.unfollow @user.id

    @follower_count = @user.follower_count
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js do
        render 'users/unfollow_user'
      end
    end
  end
<<<<<<< Updated upstream
=======

  def accept_follow
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
    @relationship = current_user.follower_relationships.find_by! follower_id: @user.id
    @relationship.destroy
    respond_to do |format|
      format.js do
        format.html { redirect_to root_path }
        render 'users/reject_follow'
      end
    end
  end

  private

  def set_user
    @user = User.find_by! id: params[:id]
  end
>>>>>>> Stashed changes
end
