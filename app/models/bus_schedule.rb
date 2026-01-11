class BusSchedule < ApplicationRecord
  belongs_to :bus
  belongs_to :route
  enum :status, { scheduled: 0, in_progress: 1, cancelled: 2 }
  validates :departure_time, presence: true
  validates :arrival_time, presence: true
  validates :available_seats, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
