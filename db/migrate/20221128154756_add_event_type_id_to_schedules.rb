class AddEventTypeIdToSchedules < ActiveRecord::Migration[7.0]
  def change
    add_reference :schedules, :event_type, null: false, foreign_key: true
    remove_column :schedules, :duration
  end
end
