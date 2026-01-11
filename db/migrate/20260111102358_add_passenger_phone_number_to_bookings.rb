class AddPassengerPhoneNumberToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :passenger_phone_number, :string
  end
end
