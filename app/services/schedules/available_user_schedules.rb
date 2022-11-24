# frozen_string_literal: true

module Schedules
  class AvailableUserSchedules
    def self.call(user:, event_type:)
      new(user, event_type).call
    end

    def initialize(user, event_type)
      @user = user
      @event_type = event_type
    end

    def call
      available_user_schedules = []
      schedules_already_filled = @user.schedules.pluck(:scheduled_at)

      previous_schedule_filled = false
      current_available_period = first_available_schedule

      while current_available_period + @event_type.each_event_duration.minutes <= @event_type.end_available_period
        if schedules_already_filled.include?(current_available_period)
          previous_schedule_filled = true
        elsif previous_schedule_filled
          previous_schedule_filled = false
          available_user_schedules << current_available_period + @event_type.break_time_amount.minutes
        else
          previous_schedule_filled = false
          available_user_schedules << current_available_period
        end

        current_available_period += @event_type.each_event_duration.minutes
      end

      available_user_schedules
    end

    private

    def first_available_schedule
      now = Time.zone.now

      if now > @event_type.start_available_period
        @event_type.start_available_period.change(hour: now.hour + 1)
      else
        @event_type.start_available_period
      end
    end
  end
end
