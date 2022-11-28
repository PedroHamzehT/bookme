# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show edit update destroy]

  def index
    @schedules = Schedule.all
  end

  def show
  end

  def new
    user = User.includes(:event_types).find_by(username: params[:username])
    event_type = user.event_types.find_by(slug: params[:event_type])

    @available_schedules = ::Schedules::AvailableUserSchedules.call(user:, event_type:)
    @schedule = user.schedules.new(event_type:)
  end

  def edit
    @available_schedules = ::Schedules::AvailableUserSchedules.call(
      user: @schedule.user,
      event_type: @schedule.event_type
    )
  end

  def create
    user = User.find_by(username: params[:username])
    event_type = EventType.find_by(slug: params[:event_type])

    @schedule = user.schedules.new(schedule_params.merge(event_type:))
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to schedule_url(@schedule), notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        @available_schedules = ::Schedules::AvailableUserSchedules.call(user:, event_type:)

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to schedule_url(@schedule), notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url, notice: "Schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:scheduled_at, :duration, :guest_name, :guest_email)
  end
end
