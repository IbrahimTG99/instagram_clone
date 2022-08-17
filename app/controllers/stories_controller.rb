class StoriesController < ApplicationController
  before_action :set_story, only: %i[show destroy]

  def index
    redirect_to root_path
  end

  def create
    @story = Story.create(story_params)
    @story.user = current_user if user_signed_in?
    if @story.save
      redirect_to root_path, flash: { success: 'story created!' }
    else
      redirect_to new_story_path, flash: { error: 'story not created!' }
    end
  end

  def new
    @story = Story.new
  end

  def show; end

  def destroy
    @story.destroy
    redirect_to root_path, flash: { success: 'story deleted!' }
  end

  private

  def set_story
    @story = Story.find(params[:id]) if params[:id].present?
  end

  def story_params
    params.require(:story).permit(:image, :caption)
  end
end
