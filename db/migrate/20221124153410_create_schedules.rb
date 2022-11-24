class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.integer :duration
      t.string :guest_first_name
      t.string :guest_last_name
      t.string :guest_email

      t.timestamps
    end
  end
end
