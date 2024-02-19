FactoryBot.define do
  factory :shopping_list do
    product {'test-food+1'}
    number { '22' }
    association :user
  end
end
