class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :event_type

  delegate :duration, to: :event_type
end
