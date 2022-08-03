require 'sidekiq-scheduler'

class RemoveStoriesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(story)
    story.destroy
  end
end
