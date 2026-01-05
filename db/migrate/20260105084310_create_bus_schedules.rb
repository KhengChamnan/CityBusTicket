class CreateBusSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :bus_schedules do |t|
      t.references :bus, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true
      t.datetime :departure_time
      t.datetime :arrival_time
      t.integer :available_seats
      t.timestamps
    end
  end
end
