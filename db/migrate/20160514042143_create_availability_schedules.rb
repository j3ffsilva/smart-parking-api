class CreateAvailabilitySchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :availability_schedules do |t|
      t.references :spot,         null: false, index: true
      t.integer    :from,         null: false
      t.integer    :to,           null: false
      t.time       :begin_time,   null: false
      t.time       :end_time,     null: false
      t.boolean    :is_available, null: false

      t.timestamps
    end
  end
end
