# frozen_string_literal: true

# Promo controller
class PromosController < ApplicationController
  before_action :set_promo, only: %i[show edit update destroy]
  before_action :company_option, only: %i[show new edit create]
  before_action :find_filter_option, only: %i[new edit create]

  def index
    @companies = Company.where(user_id: current_user.id)
    @selected_companies = @companies.first
    @promos = params[:company_id].present? ? Promo.where(company_id: params[:company_id]) : @selected_companies.promos
    @company = Company.find_by_id(params[:company_id])
    @filter_option = params[:company_id].present? ? @company.filter_options : Company.first.filter_options
  end

  def show; end

  def new
    @promo = Promo.new
  end

  def edit; end

  def create
    @promo = Promo.new(promo_params)
    respond_to do |format|
      if @promo.save
        format.html { redirect_to promo_url(@promo), notice: 'Promo was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @promo.update(promo_params)
        format.html { redirect_to promo_url(@promo), notice: 'Promo was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @promo.destroy

    respond_to do |format|
      format.html { redirect_to promos_url, notice: 'Promo was successfully destroyed.' }
    end
  end

  private

  def set_promo
    @promo = Promo.find(params[:id])
  end

  def promo_params
    params.require(:promo).permit(:name, :start_date, :end_date, :description, :company_id, :promo_id, filter_option_ids: [])
  end

  def find_filter_option
    @selected_companies = params[:company_id].present? ? Company.find_by(id: params[:company_id]) : @company.first
    @filter_option = FilterOption.where(company_id: @selected_companies.id)
  end

  def company_option
    @company = current_user.company
  end
end
