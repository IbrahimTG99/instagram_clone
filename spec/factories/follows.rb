FactoryBot.define do
  factory :follow do
    follower_id { user1 }
    following_id { user2 }
    status { 'pending' }
  end
end
