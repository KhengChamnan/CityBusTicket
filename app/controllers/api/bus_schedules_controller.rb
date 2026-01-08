class Api::BusSchedulesController < Api::BaseController
  skip_before_action :authorize_request, only: [ :index, :by_route ]
  def index
    @bus_schedules = BusSchedule.includes(:bus, route: [ :origin_province, :destination_province ]).all
    # Renders app/views/api/bus_schedules/index.json.jbuilder automatically
  end

  def by_route
    origin_id = params[:origin_id]
    destination_id = params[:destination_id]
    date = params[:date]

    # Find routes matching origin and destination
    routes = Route.all
    routes = routes.where(origin_province_id: origin_id) if origin_id.present?
    routes = routes.where(destination_province_id: destination_id) if destination_id.present?
    route_ids = routes.pluck(:id)

    # Query bus schedules by route IDs
    @bus_schedules = BusSchedule.where(route_id: route_ids).includes(:bus, route: [ :origin_province, :destination_province ])
    @bus_schedules = @bus_schedules.where("DATE(departure_time) = ?", date) if date.present?

    # Renders app/views/api/bus_schedules/by_route.json.jbuilder automatically
  end
end
