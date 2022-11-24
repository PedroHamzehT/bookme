FactoryBot.define do
  factory :event_type do
    association :user

    name                   { 'Test Event Type' }
    start_available_period { Time.new(2022, 01, 01, 06, 00, 00, 00).utc }
    end_available_period   { Time.new(2022, 01, 01, 18, 00, 00, 00).utc }
    each_event_duration    { 30 }
    break_time_amount      { 15 }
  end
end
