FactoryBot.define do
  factory :user do
    email        { 'dummy_user@test.com' }
    password     { '12345678' }
    confirmed_at { DateTime.now }
  end
end
