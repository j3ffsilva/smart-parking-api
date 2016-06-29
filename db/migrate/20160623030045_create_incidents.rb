class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.references  :user,     null: false, index: true, foreign_key: true
      t.references  :spot,     null: false, index: true, foreign_key: true
      t.integer     :category, null: false
      t.string      :comment,  null: false

      t.timestamps
    end
  end
end
