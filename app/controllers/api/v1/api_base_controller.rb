module Api::V1
  class ApiBaseController < ApplicationController
    before_action :authorize_request
    before_action :current_user
    def not_found(message)
      render json: { message: }, status: :bad_request
    end

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebTokenService.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def render_api_response(status, message, data)
      render json: { status:, message:, data: }, status:
    end

    def render_api_errorsmessage(data)
      render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
