FactoryBot.define do
    factory :user do
        title {'test-food'}
        count { '22' }
        expired_at { '05/05/2022' }
        detail {'test_words'}
        user
    end
end