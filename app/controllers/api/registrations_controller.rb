module Api
  class RegistrationsController < BaseController
    skip_before_action :authorize_request, only: [ :create ]
    # POST /api/registrations
    def create
      user = User.new(user_params)

      if user.save
        token = ::JwtService.encode({ user_id: user.id })
        render json: {
          message: "Registration successful",
          user: user.as_json(only: [ :id, :email_address ]),
          token: token
        }, status: :created
      else
        render json: {
          error: "Registration failed ",
          errors: user.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email_address, :password, :password_confirmation)
    end
  end
end
