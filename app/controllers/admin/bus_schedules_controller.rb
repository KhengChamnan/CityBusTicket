class Admin::BusSchedulesController < Admin::BaseController
  # Find the bus schedule before show, edit, update, destroy actions
  before_action :set_bus_schedule, only: [ :show, :edit, :update, :destroy ]

  # List all bus schedules with pagination
  def index
    @bus_schedules = BusSchedule.includes(:bus, :route)
                                .order(departure_time: :desc)
  end

  # Show details of a specific bus schedule
  def show
  end

  # GET /admin/bus_schedules/new
  # Display form for creating a new bus schedule
  def new
    @bus_schedule = BusSchedule.new
    load_form_data
  end

  # Create a new bus schedule
  def create
    @bus_schedule = BusSchedule.new(bus_schedule_params)

    if @bus_schedule.save
      redirect_to admin_bus_schedule_path(@bus_schedule),
                  notice: "Bus schedule was successfully created."
    else
      load_form_data
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/bus_schedules/:id/edit
  # Display form for editing an existing bus schedule
  def edit
    load_form_data
  end

  # PATCH/PUT /admin/bus_schedules/:id
  # Update an existing bus schedule
  def update
    if @bus_schedule.update(bus_schedule_params)
      redirect_to admin_bus_schedule_path(@bus_schedule),
                  notice: "Bus schedule was successfully updated."
    else
      load_form_data
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/bus_schedules/:id
  # Delete a bus schedule
  def destroy
    @bus_schedule.destroy
    redirect_to admin_bus_schedules_path,
                notice: "Bus schedule was successfully deleted."
  end

  # logout method
  def logout
    # Admin logout logic
    reset_session
    redirect_to new_session_path, notice: "Logged out successfully."
  end

  private

  # Find bus schedule by ID
  def set_bus_schedule
    @bus_schedule = BusSchedule.find(params[:id])
  end

  # Strong parameters - only allow permitted attributes
  def bus_schedule_params
    params.require(:bus_schedule).permit(
      :bus_id,
      :route_id,
      :departure_time,
      :arrival_time,
      :available_seats,
      :seat_price,
      :status
    )
  end

  # Load data needed for the form dropdowns
  def load_form_data
    @buses = Bus.all
    @routes = Route.includes(:origin_province, :destination_province).all
  end
end
