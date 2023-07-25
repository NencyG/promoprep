module Api::V1
  class CompaniesController < ApiBaseController
    skip_before_action :verify_authenticity_token
    before_action :current_user_company, only: %i[index show update destroy]
    before_action :find_company, only: %i[show update destroy]

    def index
      if @companies.present?
        response_200('Fetched all the Companies Successfully',
                            @companies)
      else
        response_400('Company is not Available')
      end
    end

    def create
      @company = Company.new(company_params.merge!(user_id: @current_user.id))
      begin
        @company.save!
        response_200('Fetched all the Companies Successfully', @company)
      rescue StandardError => e
        response_422(e.message, 'Failed to save Company. Please try again Later')
      end
    end

    def show
      if @company
        response_200('Success', @company)
      else
        response_400('Company could not be Found')
      end
    end

    def update
      if @company.present?
        begin
          @company.update!(company_params)
          response_200('Company was updated Sucessfully', @company)
        rescue StandardError => e
          response_422(e.message, 'Failed to update the Company')
        end
      else
        response_400('You can not Update this Company')
      end
    end

    def destroy
      if @company.present?
        @company.destroy
        response_200('Company was Delete Successfully', @company)
      else
        response_400('Company does not Exist')
      end
    end

    private

    def company_params
      params.require(:company).permit(:name, :email)
    end

    def current_user_company
      @companies = @current_user.companies
    end

    def find_company
      @company = @companies.find_by(id: params[:id])
    end
  end
end
