class CreateRoutes < ActiveRecord::Migration[8.1]
  def change
    create_table :routes do |t|
      t.integer :origin_province_id
      t.integer :destination_province_id
      t.decimal :distance_km
      t.integer :duration_min
      t.timestamps
    end
  end
end
