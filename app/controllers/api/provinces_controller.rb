class Api::ProvincesController < Api::BaseController
  def index
    provinces = Province.all
    render json: provinces
  end
end
