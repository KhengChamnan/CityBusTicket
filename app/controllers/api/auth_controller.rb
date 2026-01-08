module Api
  class AuthController < BaseController
    skip_before_action :authorize_request, only: [ :login, :refresh ]

    # POST /api/auth/login
    def login
      @user = User.find_by(email_address: params[:email_address])

      if @user&.authenticate(params[:password])
        @token = JwtService.encode({ user_id: @user.id })
        @message = "Login successful"
        # Renders app/views/api/auth/login.json.jbuilder
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    # POST /api/auth/refresh
    def refresh
      old_token = params[:token]

      if old_token.blank?
        render json: { error: "Token is required" }, status: :bad_request
        return
      end

      decoded = JwtService.decode(old_token)

      if decoded
        @user = User.find_by(id: decoded[:user_id])
        if @user
          @token = JwtService.encode({ user_id: @user.id })
          @message = "Token refreshed successfully"
          # Renders app/views/api/auth/refresh.json.jbuilder
        else
          render json: { error: "User not found" }, status: :unauthorized
        end
      else
        render json: { error: "Invalid or expired token" }, status: :unauthorized
      end
    end

    # GET /api/auth/me
    def me
      @user = current_user
      # Renders app/views/api/auth/me.json.jbuilder
    end
  end
end
