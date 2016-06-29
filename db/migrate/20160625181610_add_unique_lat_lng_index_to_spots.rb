class AddUniqueLatLngIndexToSpots < ActiveRecord::Migration[5.0]
  def change
    add_index :spots, [:latitude, :longitude], unique: true
  end
end
