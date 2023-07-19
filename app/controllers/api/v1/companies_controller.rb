class Api::V1::CompaniesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @companies = Company.all
    render json: { status: 200, message: 'Fetched all the companies successfully', data: @companies }, status: :ok
  end

  def create
    @company = Company.new(company_params.merge!(user_id: 1))
    if @company.save
      render json: { status: 201, message: 'Company was created successfully!', data: @company }, status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def show
    @companies = Company.find_by(id: params[:id])
    if @companies
      render json: { status: 200, message: 'Success', data: @companies }, status: :ok
    else
      render json: { message: 'Company could not be found' }, status: :bad_request
    end
  end

  def update
    @company = Company.find_by(id: params[:id])
    if @company.update!(company_params)
      render json: { message: 'Company was updated sucessfully', data: @company }, status: :ok
    else
      render json: { message: 'Company cannot be update' }, status: :unprocessable_entity
    end
  end

  def destroy
    @company = Company.find_by(id: params[:id])

    if @company.present?
      @company.destroy
      render json: { message: 'Company was delete successfully' }, status: :ok
    else
      render json: { message: 'Company does not exist' }, status: :bad_request
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :email)
  end
end
