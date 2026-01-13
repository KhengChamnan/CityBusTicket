class Api::PaymentsController < Api::BaseController
  def index
    @payments = @current_user.payments.all
  end

  def create
    payment_params = params.require(:payment).permit(:booking_id, :payment_method)
    booking = @current_user.bookings.find(payment_params[:booking_id])
    payment = Payment.new(payment_params.merge(booking: booking))
    if payment_params[:payment_method] != "cash" && @current_user.credit < booking.total_price
      render json: { status: "error", errors: [ "Insufficient credit" ] }, status: :unprocessable_entity
      return
    end
    if payment.save
      PaymentProcessor.new(payment).call
      render json: { status: "success", payment: payment }, status: :created
    else
      render json: { status: "error", errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
