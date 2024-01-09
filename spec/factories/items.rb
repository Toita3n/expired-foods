FactoryBot.define do
    factory :item do
        title {'test-food'}
        count { '22' }
        expired_at { '05/05/2022' }
        detail {'test_words'}
        
        association :user
    end
end