module Api::V1
  class CompaniesController < ApiBaseController
    skip_before_action :verify_authenticity_token
    before_action :current_user_company, only: %i[index show update destroy]

    def index
      if @companies.present?
        render_api_response(200, 'Fetched all the companies successfully',
                            @companies)
      else
        not_found('Company is not Available')
      end
    end

    def create
      @company = Company.new(company_params.merge!(user_id: 1))
      if @company.save
        render_api_response(201, 'Company was created successfully!', @company)
      else
        render_api_errorsmessage(@company)
      end
    end

    def show
      @company = @companies.find_by(id: params[:id])
      if @company
        render_api_response(200, 'Success', @company)
      else
        not_found('Company could not be found')
      end
    end

    def update
      @company = @companies.find_by(id: params[:id])
      if @company.update!(company_params)
        render_api_response(200, 'Company was updated sucessfully', @company)
      else
        render_api_errorsmessage(@company)
      end
    end

    def destroy
      @company = @companies.find_by(id: params[:id])

      if @company.present?
        @company.destroy
        render_api_response(200, 'Company was delete successfully', @company)
      else
        not_found('Company does not exist')
      end
    end

    private

    def company_params
      params.require(:company).permit(:name, :email)
    end

    def current_user_company
      @companies = @current_user.companies
    end
  end
end
