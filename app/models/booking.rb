class Booking < ApplicationRecord
  before_validation :calculate_total_price
  belongs_to :bus_schedule
  belongs_to :user
  has_one :payment, dependent: :destroy
  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }
  validates :passenger_name, presence: true
  validates :number_of_seats, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :passenger_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :passenger_phone_number, presence: true

  # callback for realtime update
  after_create_commit :broadcast_new_booking
  after_update_commit :broadcast_new_booking

  private
  def calculate_total_price
    seat_price = bus_schedule.seat_price
    self.total_price = seat_price * number_of_seats
  end
  # when new booking created add to top of list
  def broadcast_new_booking
    broadcast_prepend_later_to(
      "bookings",
      target: "bookings_table",
      partial: "admin/bookings/booking_row",
      locals: { booking: self }
    )
  end
end
