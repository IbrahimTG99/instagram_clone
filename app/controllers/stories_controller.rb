class StoriesController < ApplicationController
  before_action :set_story, only: %i[show destroy]

  def index
    redirect_to root_path
  end

  def create
    authorize Story
    @story = Story.create(story_params)
    @story.user = current_user
    if @story.save
      redirect_to root_path, flash: { success: 'story created!' }
    else
      render :new, flash: { danger: 'story not created!' }
    end
  end

  def new
    @story = Story.new
  end

  def destroy
    authorize @story
    @story.image.purge
    @story.destroy
    redirect_to root_path, flash: { success: 'story deleted!' }
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:image, :caption)
  end
end
