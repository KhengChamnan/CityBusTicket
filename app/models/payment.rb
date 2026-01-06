class Payment < ApplicationRecord
  before_validation :set_amount
  belongs_to :booking
  validates :payment_method, presence: true
  enum :status, { pending: 0, completed: 1, failed: 2 }

  private
  #amount=totalprice from booking
  def set_amount
    self.amount = booking.total_price
  end
end
