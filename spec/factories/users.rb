FactoryBot.define do
  factory :user do
      name { Faker::Name.last_name }
      email { Faker::Internet.unique.email }
      role {0}
  end
end
