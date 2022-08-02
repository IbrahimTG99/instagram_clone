class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  after_commit :create_story_job, on: :create

  private

  def create_story_job
    # enqueue a job to create a story after 24 hours
    StoryJob.set(wait: 24.hours).perform_later(self)
  end
end
