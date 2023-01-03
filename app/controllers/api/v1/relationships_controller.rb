class Api::V1::RelationshipsController < ActionController::Base
  include ActionController::MimeResponds

  def index
    followers = User.all
    render json: followers
  end

end
