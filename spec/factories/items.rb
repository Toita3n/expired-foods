FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "コーヒー#{n}" }
    count { '22' }
    expired_at { 3.week.from_now }
    detail {'test_words'}
    user
  end
end
