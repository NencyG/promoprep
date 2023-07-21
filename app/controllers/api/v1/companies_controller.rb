module Api::V1
  class CompaniesController < ApiBaseController
    skip_before_action :verify_authenticity_token

    def index
      @companies = Company.all
      render_api_response(200, 'Fetched all the companies successfully', @companies)
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
      @companies = Company.find_by(id: params[:id])
      if @companies
        render_api_response(200, 'Success', @companies)
      else
        not_found('Company could not be found')
      end
    end

    def update
      @company = Company.find_by(id: params[:id])
      if @company.update!(company_params)
        render_api_response(200, 'Company was updated sucessfully', @company)
      else
        render_api_errorsmessage(@company)
      end
    end

    def destroy
      @company = Company.find_by(id: params[:id])

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
  end
end
