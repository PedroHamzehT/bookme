class CreateEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :event_types do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :start_available_period, null: false
      t.datetime :end_available_period, null: false
      t.integer :each_event_duration, null: false
      t.integer :break_time_amount

      t.timestamps
    end
  end
end
