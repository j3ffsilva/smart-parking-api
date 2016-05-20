class CreatePricingSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :pricing_schedules do |t|
      t.references :spot,         null: false, index: true, foreign_key: true
      t.integer    :from,         null: false
      t.integer    :to,           null: false
      t.time       :begin_time,   null: false
      t.time       :end_time,     null: false
      t.decimal    :price,        null: false, precision: 6, scale: 2

      t.timestamps
    end
  end
end
