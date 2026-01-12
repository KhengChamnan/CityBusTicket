# Controller for viewing users (read-only)
# Admin can view list of users and user details
class Admin::UsersController < Admin::BaseController
  # GET /admin/users
  # List all users
  def index
    @users = User.order(created_at: :desc)
  end

  # GET /admin/users/:id
  # Show details of a specific user
  def show
    @user = User.find(params[:id])
    @bookings = @user.bookings.includes(bus_schedule: [ :bus, :route ])
                              .order(created_at: :desc)
  end
end
