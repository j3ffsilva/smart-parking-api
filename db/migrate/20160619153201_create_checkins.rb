class CreateCheckins < ActiveRecord::Migration[5.0]
  def change
    create_table :checkins do |t|
      t.references :user,          index: true, foreign_key: true, null: false
      t.references :spot,          index: true, foreign_key: true, null: false
      t.datetime   :checked_in_at,                                 null: false
      t.datetime   :checked_out_at

      t.timestamps
    end
  end
end
