# frozen_string_literal: true

# Promo controller
class PromosController < ApplicationController
  before_action :set_promo, only: %i[show edit update destroy]
  before_action :company_option, only: %i[show new edit create]
  before_action :find_filter_option, only: %i[new edit create]

  def index
    @companies = current_user.companies
    @selected_companys = Company.find_by_id(params[:company_id]) || @companies.first
    @filter_options = @selected_companys.filter_options
    @filter_option_ids = params[:filter_option_id]&.split(',')
    @promos = if params[:company_id].present? && @filter_option_ids.present?
                @selected_companys.promos.includes(:filter_options).where(filter_options: { id: [@filter_option_ids] })
              else
                @selected_companys.promos.includes(:filter_options)
              end
  end

  def export
    @promos = Promo.where(company_id: params[:company_id])
    send_data @promos.to_csv, filename: "promos-#{Date.today}.csv"
  end

  def import
    file = params[:file]
    return redirect_to promos_path, notice: 'Only CSV please' unless file.content_type == 'text/csv'
    CsvImportUsersService.new.call(file)
    redirect_to promos_path, notice: 'Users imported!'
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
        PromoEmailJob.perform_later(@promo)
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
    params.require(:promo).permit(:name, :start_date, :end_date, :description, :status, :company_id, :promo_id,
                                  filter_option_ids: [])
  end

  def find_filter_option
    @selected_companies = params[:company_id].present? ? Company.find_by(id: params[:company_id]) : @company.first
    @filter_options  = FilterOption.where(company_id: @selected_companies.id)
  end

  def company_option
    @company = current_user.companies
  end
end
