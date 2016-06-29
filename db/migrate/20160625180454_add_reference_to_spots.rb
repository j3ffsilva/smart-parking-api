class AddReferenceToSpots < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :reference, :text
  end
end
