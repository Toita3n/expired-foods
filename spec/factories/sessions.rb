FactoryBot.define do
  factory :session do
    email { Faker::Internet.unique.email }
    password { "testpassword" }
  end
end
