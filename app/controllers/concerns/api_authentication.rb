# app/controllers/concerns/api_authentication.rb
module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
    attr_reader :current_user
  end

  private

  def authorize_request
    payload = JwtService.decode(token)
    if payload && payload[:user_id]
      @current_user = User.find(payload[:user_id])
    else
      render json: { error: "Unauthorized. You need to log in." }, status: :unauthorized
    end
  end

  def token
    request.headers["Authorization"]&.split(" ")&.last
  end
end
