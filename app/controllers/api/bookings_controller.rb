class Api::BookingsController < Api::BaseController
  def index
    bookings = Booking.includes(bus_schedule: [ :bus, :route ], payment: [])
    render json: bookings.map { |booking|
      booking.as_json.merge(
          departure_time: booking.bus_schedule.departure_time,
          bus: booking.bus_schedule.bus.plate_number,
          origin: booking.bus_schedule.route.origin_province.name,
          destination: booking.bus_schedule.route.destination_province.name,
          payment_status: booking.payment&.status,
          payment_amount: booking.payment&.amount,
          payment_method: booking.payment&.payment_method
      )
    }
  end

  # create booking
  def create
    booking_params = params.require(:booking).permit(:bus_schedule_id, :passenger_name, :passenger_email, :number_of_seats, :status)
    booking = Booking.new(booking_params)
    booking.status = :pending

    if booking.save
      render json: { status: "success", booking: booking }, status: :created
    else
      render json: { status: "error", errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # new actions
  def new
    booking = Booking.new
    render json: { booking: booking }
  end
end
