class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :scheduled_at, null: false
      t.integer :duration, null: false
      t.string :guest_name, null: false
      t.string :guest_email, null: false

      t.timestamps
    end
  end
end
