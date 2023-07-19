module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        @companies = Company.all
        render json: { status: 200, message: 'Fetched all the companies successfully', data: @companies }, status: :ok
      end

      def show
        @companies = Company.find_by(id: params[:id])
        if @companies
          render json: { status: 200, message: 'Success', data: @companies }, status: :ok
        else
          render json: { error: 'Company Not Found', status: :bad_request }
        end
      end
    end
  end
end
