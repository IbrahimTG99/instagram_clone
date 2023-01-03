FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    private { false }
  end
end
