# frozen_string_literal: true

# Promo controller
class PromosController < ApplicationController
  before_action :set_promo, only: %i[show edit update destroy]

  def index
    @companies = Company.where(user_id: current_user.id)
    @selected_companies = @companies.first
    @promos = if params[:company_id]
                Promo.where(company_id: params[:company_id])
              else
                @selected_companies.promos
              end
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

  def filtter
    @company_name = Promo.where('location' => params[:requested_area])
    respond_to do |format|
      format.js
    end
  end

  private

  def set_promo
    @promo = Promo.find(params[:id])
  end

  def promo_params
    params.require(:promo).permit(:name, :start_date, :end_date, :description, :company_id)
  end
end
