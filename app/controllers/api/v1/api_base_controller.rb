module Api::V1
  class ApiBaseController < ApplicationController
    before_action :current_user
    before_action :authorize_request
    def not_found(message)
      render json: { message: }, status: :bad_request
    end

    def authorize_request
      return unless current_user

      render json: { message: 'Please Login first' }
    end

    def decoded_token
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      return unless header

      begin
        @decoded_token ||= JsonWebToken.decode(header)
      rescue Error => e
        render json: { errors: [e.message] }, status: :unauthorized
      end
    end

    def current_user
      @current_user = nil
      return unless decoded_token

      data = decoded_token
      @user = User.find_by(id: data[:user_id])
      return unless @user

      @current_user ||= @user
    end

    def render_api_response(status, message, data)
      render json: { status:, message:, data: }, status:
    end

    def render_api_errorsmessage(data)
      render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
