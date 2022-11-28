# frozen_string_literal: true

module Schedules
  class AvailableUserSchedules
    START_TIME_INCREMENTATION = 30

    def self.call(user:, event_type:)
      new(user, event_type).call
    end

    def initialize(user, event_type)
      @user = user
      @event_type = event_type
      @schedules_already_filled = @user.schedules.pluck(:scheduled_at)
      @available_schedules = []
      @last_scheduled_time = nil
    end

    def call
      current_available_schedule = first_available_schedule

      while valid_current_available_schedule?(current_available_schedule)
        if @schedules_already_filled.include?(current_available_schedule)
          @last_scheduled_time = current_available_schedule
          remove_last_available_schedule(current_available_schedule)
        elsif @last_scheduled_time
          unless last_available_schedule_conflicts_with_current?(current_available_schedule, 'after')
            @available_schedules << current_available_schedule
          end

          @last_scheduled_time = nil
        else
          @last_scheduled_time = nil
          @available_schedules << current_available_schedule
        end

        current_available_schedule += START_TIME_INCREMENTATION.minutes
      end

      @available_schedules
    end

    private

    def valid_current_available_schedule?(current_available_schedule)
      current_available_schedule +
        START_TIME_INCREMENTATION.minutes +
        @event_type.duration.minutes <= @event_type.end_available_period
    end

    def last_available_schedule_conflicts_with_current?(current_available_schedule, break_time_type)
      break_time = @event_type.send("#{break_time_type}_break_time")
      @last_scheduled_time + @event_type.duration.minutes + break_time.minutes > current_available_schedule
    end

    def first_available_schedule
      now = Time.zone.now

      if now > @event_type.start_available_period
        @event_type.start_available_period.change(hour: now.hour + 1)
      else
        @event_type.start_available_period
      end
    end

    def remove_last_available_schedule(current_available_schedule)
      return unless last_available_schedule_conflicts_with_current?(current_available_schedule, 'before')

      @available_schedules.pop
    end
  end
end
