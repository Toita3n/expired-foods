FactoryBot.define do
  factory :inquiry do
    email { Faker::Internet.unique.email }
    text { "test-infomation-to-check-this-inquiry" }
  end
end
