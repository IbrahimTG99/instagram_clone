FactoryBot.define do
  factory :comment do
    user
    post
    content { Faker::Lorem.paragraph }
  end
end
