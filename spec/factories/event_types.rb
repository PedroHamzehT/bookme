# frozen_string_literal: true

FactoryBot.define do
  factory :event_type do
    association :user

    name                   { 'Test Event Type' }
    start_available_period { Time.new(2022, 1, 1, 6, 0, 0, 0).utc }
    end_available_period   { Time.new(2022, 1, 1, 18, 0, 0, 0).utc }
    duration               { 30 }
    before_break_time      { 15 }
    after_break_time       { 15 }
  end
end
