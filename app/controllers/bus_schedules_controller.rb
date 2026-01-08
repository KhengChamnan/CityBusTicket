class BusSchedulesController < ApplicationController
  def index
    @bus_schedules = BusSchedule.includes(:bus, :route).all
  end
end
