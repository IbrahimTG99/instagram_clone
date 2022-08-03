require 'sidekiq-scheduler'

class RemoveStoriesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    @stories = Story.where('created_at <= ?', 1.day.ago)
    @stories.destroy_all
  end
end
