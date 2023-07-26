# frozen_string_literal: true

# Compaines controller
class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @companies = current_user.companies
  end

  def show; end

  def new
    @company = Company.new
    @company.filter_options.build
  end

  def edit; end

  def create
    @company = Company.new(company_params.merge!(user_id: current_user.id))

    respond_to do |format|
      if @company.save
        format.html { redirect_to company_url(@company), notice: 'Company was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: 'Company was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :email, filter_options_attributes: %i[
                                      id
                                      name
                                      is_active
                                      _destroy
                                    ])
  end
end
