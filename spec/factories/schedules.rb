# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    user { nil }
    scheduled_at { '2022-11-24 12:34:10' }
    duration { 1 }
    guest_name { 'MyString' }
    guest_email { 'MyString' }
  end
end
