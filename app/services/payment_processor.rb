class PaymentProcessor
  def initialize(payment)
    @payment = payment
  end

  def call
    ActiveRecord::Base.transaction do
      deduct_user_credit unless @payment.payment_method == "cash"
      confirm_booking
      @payment.update!(status: :completed)
      @payment
    end
  end

  private

  def deduct_user_credit
    user = @payment.booking.user
      user.update!(credit: user.credit - @payment.amount)
  end

  def confirm_booking
    @payment.booking.update!(status: :confirmed)
  end
end
