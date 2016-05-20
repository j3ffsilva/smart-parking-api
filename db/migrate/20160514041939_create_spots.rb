class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.references  :establishment,     index: true, foreign_key: true
      t.string      :parking_type,      null: false
      t.integer     :status,            null: false
      t.boolean     :is_outdoor,        null: false
      t.boolean     :is_preferential,   null: false
      t.decimal     :latitude,          null: false, precision: 15, scale: 12
      t.decimal     :longitude,         null: false, precision: 15, scale: 12

      t.timestamps
    end
  end
end
