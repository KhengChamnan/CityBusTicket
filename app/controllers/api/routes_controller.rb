class Api::RoutesController < Api::BaseController
  def index
    routes = Route.includes(:origin_province, :destination_province)
    render json: routes.map { |route|
      route.as_json.merge(
        origin_province: route.origin_province.name,
        destination_province: route.destination_province.name
      )
    }
  end
end
