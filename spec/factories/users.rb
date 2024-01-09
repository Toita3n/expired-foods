FactoryBot.define do
    factory :user do
        name { Faker::JapaneseMedia::Doraemon }
        email { Faker::Internet.email }
        password { 'testpassword' }
        crypted_password { password }
    end
end