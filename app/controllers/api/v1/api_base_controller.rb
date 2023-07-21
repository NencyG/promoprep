module Api::V1
  class ApiBaseController < ApplicationController
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def render_api_response(status, data)
      render json: { status: status, message: 'Success', data: data }, status: status
    end

    def render_api_errorsmessage
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
