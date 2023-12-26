FactoryBot.define do
    factory :user do
        name {'tester'}
        email { 'test@example.com' }
        password { 'testpassword' }
    end
end