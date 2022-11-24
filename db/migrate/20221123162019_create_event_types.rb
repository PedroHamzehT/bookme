class CreateEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :event_types do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.datetime :start_available_period, null: false
      t.datetime :end_available_period, null: false
      t.integer :duration, null: false
      t.integer :before_break_time, default: 0
      t.integer :after_break_time, default: 0

      t.timestamps
    end
  end
end
