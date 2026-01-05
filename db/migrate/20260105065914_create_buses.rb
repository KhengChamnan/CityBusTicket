class CreateBuses < ActiveRecord::Migration[8.1]
  def change
    create_table :buses do |t|
      t.string :plate_number
      t.string :model
      t.integer :capacity

      t.timestamps
    end
  end
end
