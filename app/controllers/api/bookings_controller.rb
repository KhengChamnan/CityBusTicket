class Api::BookingsController < Api::BaseController
  def index
    @bookings = @current_user.bookings.includes(bus_schedule: [ :bus, :route ], payment: []).all
  end

  # create booking
  def create
    booking_params = params.require(:booking).permit(:bus_schedule_id, :passenger_name, :passenger_email, :number_of_seats, :status)
    booking = Booking.new(booking_params)
    booking.user = @current_user
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
