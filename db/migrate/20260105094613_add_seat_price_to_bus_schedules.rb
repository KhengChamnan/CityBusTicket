class AddSeatPriceToBusSchedules < ActiveRecord::Migration[8.1]
  def change
    add_column :bus_schedules, :seat_price, :decimal
  end
end
