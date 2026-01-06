class Api::ProvincesController < ApplicationController
  def index
    provinces = Province.all
    render json: provinces
  end
end
