json.array! @bus_schedules do |schedule|
  # Extract basic schedule fields
  json.extract! schedule, :id, :departure_time, :arrival_time, :seat_price, :available_seats, :status

  # Bus information
  json.bus do
    json.plate_number schedule.bus.plate_number
    json.capacity schedule.bus.capacity
  end

  # Route information with nested provinces
  json.route do
    json.id schedule.route.id
    json.origin schedule.route.origin_province.name
    json.destination schedule.route.destination_province.name
    json.distance schedule.route.distance if schedule.route.respond_to?(:distance)
  end
end
