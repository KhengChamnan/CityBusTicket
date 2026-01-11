class Api::ProvincesController < Api::BaseController
  skip_before_action :authorize_request, only: [ :index ]
  def index
    provinces = Province.all
    render json: provinces
  end
end
