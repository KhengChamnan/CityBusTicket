class Booking < ApplicationRecord
  before_validation :calculate_total_price
  belongs_to :bus_schedule
  has_one :payment
  validates :passenger_name, presence: true
  validates :number_of_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :passenger_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  private
  def calculate_total_price
    seat_price = bus_schedule.seat_price
    self.total_price = seat_price * number_of_seats
  end
end
