class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :bus_schedule, null: false, foreign_key: true
      t.string :passenger_name
      t.string :passenger_email
      t.integer :number_of_seats
      t.decimal :total_price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
