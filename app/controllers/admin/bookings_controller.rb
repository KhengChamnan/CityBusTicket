# Controller for viewing bookings (read-only)
# Admin can view list of all bookings and booking details
class Admin::BookingsController < Admin::BaseController
  # GET /admin/bookings
  # List all bookings
  def index
    @bookings = Booking.includes(:user, bus_schedule: [ :bus, :route ])
                       .order(created_at: :desc)
  end

  # GET /admin/bookings/:id
  # Show details of a specific booking
  def show
    @booking = Booking.includes(:user, :payment, bus_schedule: [ :bus, :route ])
                      .find(params[:id])
  end
end
