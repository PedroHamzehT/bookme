# frozen_string_literal: true

class EventTypesController < ApplicationController
  before_action :authenticate_user!

  def index
    @event_types = EventType.all
  end

  def new
    @event_type = EventType.new
  end

  def create
    debugger
    @event_type = current_user.event_types.new(event_type_params)
    @event_type.start_available_period = @event_type.start_available_period.change(year: 1000, month: 01, day: 01)
    @event_type.end_available_period = @event_type.end_available_period.change(year: 1000, month: 01, day: 01)

    if @event_type.save
      redirect_to me_url, notice: 'Event type created successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_type_params
    params.require(:event_type).permit(
      :name,
      :start_available_period,
      :end_available_period,
      :each_event_duration,
      :break_time_amount
    )
  end
end
