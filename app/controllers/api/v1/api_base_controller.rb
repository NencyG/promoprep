module Api::V1
  class ApiBaseController < ApplicationController
    include JsonApiResponse
    before_action :authorize_request
    before_action :current_user
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebTokenService.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        response_401(e.message)
      rescue JWT::DecodeError => e
        response_401(e.message)
      end
    end
  end
end
