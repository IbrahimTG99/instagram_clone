class Follow < ApplicationRecord
  belongs_to :follower,  class_name: :User
  belongs_to :following, class_name: :User
  enum status: { pending: 0, accepted: 1 }

  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates :status, presence: true, inclusion: { in: %w(pending accepted) }

end
