class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.string   :google_place_id, null: false

      t.timestamps
    end
  end
end
