module Api::V1
  class CompaniesController < ApiBaseController
    skip_before_action :verify_authenticity_token
    before_action :current_user_company, only: %i[index show update destroy]
    before_action :find_cpmpany, only: %i[show update destroy]

    def index
      if @companies.present?
        response_200('Fetched all the companies successfully',
                            @companies)
      else
        response_400('Company is not Available')
      end
    end

    def create
      @company = Company.new(company_params.merge!(user_id: @current_user.id))
      if @company.save
        response_201('Company was created successfully!', @company)
      else
        response_422(@company, 'Failed to save company. Please try again later')
      end
    end

    def show
      if @company
        response_200('Success', @company)
      else
        response_400('Company could not be found')
      end
    end

    def update
      if @company.present?
        @company.update!(company_params)
        response_200('Company was updated sucessfully', @company)
      else
        response_400('You can not update this company')
      end
    end

    def destroy
      if @company.present?
        @company.destroy
        response_200('Company was delete successfully', @company)
      else
        response_400('Company does not exist')
      end
    end

    private

    def company_params
      params.require(:company).permit(:name, :email)
    end

    def current_user_company
      @companies = @current_user.companies
    end

    def find_cpmpany
      @company = @companies.find_by(id: params[:id])
    end
  end
end
