class StoryJob < ApplicationJob
  queue_as :default

  def perform(story)
    story.destroy
  end
end
