class Api::BusSchedulesController < ApplicationController
  def index
    bus_schedules = BusSchedule.includes(:bus, :route)
    render json: bus_schedules.map { |schedule|
      schedule.as_json.merge(
        bus: schedule.bus.plate_number,
        route: {
          origin: schedule.route.origin_province.name,
          destination: schedule.route.destination_province.name
        }
      )
    }
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
  bus_schedules = BusSchedule.where(route_id: route_ids).includes(:bus, :route)
  bus_schedules = bus_schedules.where("DATE(departure_time) = ?", date) if date.present?

  render json: bus_schedules.map { |schedule|
    schedule.as_json.merge(
      bus: schedule.bus.plate_number,
      route: {
        origin: schedule.route.origin_province.name,
        destination: schedule.route.destination_province.name
      }
    )
  }
  end
end
