class Api::V1::StoriesController < ActionController::Base
  include ActionController::MimeResponds
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    stories = Story.all
    render json: stories
  end

  def show
    story = Story.find(params[:id])
    render json: story.as_json.merge(:url => story.image.service_url)
  end

  private

    def not_found
        render json: { message: "Story with id: #{params[:id]} Not found" }, status: :not_found
    end
end
