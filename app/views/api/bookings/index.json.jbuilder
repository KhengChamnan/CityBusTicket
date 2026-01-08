json.array! @bookings do |booking|
  json.extract! booking, :id, :passenger_name, :passenger_email, :number_of_seats, :status

  json.departure_time booking.bus_schedule.departure_time
  json.bus booking.bus_schedule.bus.plate_number
  json.origin booking.bus_schedule.route.origin_province.name
  json.destination booking.bus_schedule.route.destination_province.name

  json.payment_status booking.payment&.status
  json.payment_amount booking.payment&.amount
  json.payment_method booking.payment&.payment_method
end
