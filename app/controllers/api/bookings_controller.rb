class Api::BookingsController < ApplicationController
  def index
    bookings = Booking.includes(bus_schedule: [ :bus, :route ])
    render json: bookings.map { |booking|
      booking.as_json.merge(
        bus_schedule: {
          departure_time: booking.bus_schedule.departure_time,
          bus: booking.bus_schedule.bus.plate_number,
          route: {
            origin: booking.bus_schedule.route.origin_province.name,
            destination: booking.bus_schedule.route.destination_province.name
          }
        }
      )
    }
  end

  # create booking
  def create
    booking_params = params.require(:booking).permit(:bus_schedule_id, :passenger_name, :passenger_email, :seat_number)
    booking = Booking.new(booking_params)

    if booking.save
      render json: { status: "success", booking: booking }, status: :created
    else
      render json: { status: "error", errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
