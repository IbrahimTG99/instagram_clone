FactoryBot.define do
  factory :post do
    caption { Faker::Lorem.paragraph }
    user
    images { Rack::Test::UploadedFile.new('app/assets/images/default_profile.jpg', 'image/jpg') }
  end
end
