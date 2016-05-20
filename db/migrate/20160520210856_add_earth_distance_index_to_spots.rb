class AddEarthDistanceIndexToSpots < ActiveRecord::Migration[5.0]
  def change
    add_earthdistance_index :spots, lat: :latitude, lng: :longitude
  end
end
