module Api::V1
  class CompaniesController < ApiBaseController
    skip_before_action :verify_authenticity_token
    before_action :current_user_company, only: %i[index show update destroy]
    before_action :find_company, only: %i[show update destroy]

    def index
      if @companies.present?
        companies = { companies: serialized_companies }
        response_200('Fetched all the Companies Successfully', companies)
      else
        response_400('Company is not Available')
      end
    end

    def create
      @company = Company.new(company_params.merge(user_id: @current_user.id))

      if @company.save!
        company = { company: serialized_company }
        response_200('Company created successfully', company)
      else
        response_422(@company.errors.full_messages.join(', '), 'Failed to save the Company.')
      end
    end

    def show
      if @company
        company = { company: serialized_company }
        response_200('Success', company)
      else
        response_400('Company could not be Found')
      end
    end

    def update
      if @company.present?
        if @company.update(company_params)
          company = { company: serialized_company }
          response_200('Company was updated Successfully', company)
        else
          response_422(@company.errors.full_messages.join(', '), 'Failed to update the Company.')
        end
      else
        response_400('You cannot Update this Company')
      end
    end

    def destroy
      if @company.present?
        @company.destroy
        company = { company: serialized_company }
        response_200('Company was Deleted Successfully', company)
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

    def serialized_companies
      CompanySerializer.new(@companies).serializable_hash[:data]
    end

    def serialized_company
      CompanySerializer.new(@company).serializable_hash[:data]
    end
  end
end
