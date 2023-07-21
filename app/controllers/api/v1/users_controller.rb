module Api::V1
  class UsersController < ApiBaseController
    skip_before_action :verify_authenticity_token
    before_action :authorize_request, except: :create
    before_action :find_user, except: %i[create index]

    def index
      @users = User.all
      render_api_response(200, 'Fetched all the User successfully', @users)
    end

    def show
      render_api_response(200, 'Success', @user)
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render_api_response(201, 'User was created successfully!', @user)
      else
        render_api_errorsmessage(@user)
      end
    end

    def update
      return if @user.update(user_params)

      render_api_errorsmessage(@user)
    end

    def destroy
      @user.destroy
      render_api_response(200, 'User was delete successfully', @company)
    end

    private

    def find_user
      @user = User.find_by!(id: params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.permit(
        :first_name, :last_name, :age, :dob, :email, :password, :password_confirmation
      )
    end
  end
end
