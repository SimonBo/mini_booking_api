module Concerns
  module JwtHandling
    extend ActiveSupport::Concern

    def set_current_user
      if decoded_auth_token
        @current_user = User.find(decoded_auth_token[:user_id])
      end
    end

    def decoded_auth_token
      if request.headers['Authorization'].present?
        token = request.headers['Authorization'].split(' ').last
        JsonWebToken.decode(token)
      end
    end

    def authenticate_request
      unless @current_user
        render json: { errors: "Not Authorized" }, status: :unauthorized
      end
    end

  end
end
