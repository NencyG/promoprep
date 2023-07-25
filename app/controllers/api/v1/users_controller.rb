module Api::V1
  class UsersController < ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorize_request, only: :create
    before_action :find_user, except: %i[create index]

    def index
      @users = User.all
      @users.present? ? response_200('Fetched all the User successfully', @users) : response_400('User is not Available')
    end

    def show
      response_200('Success', @user)
    end

    def create
      @user = User.new(user_params = {
                         email: params[:email],
                         password: params[:password],
                         first_name: params[:first_name],
                         last_name: params[:last_name],
                         age: params[:age],
                         dob: params[:dob]
                       })
      if @user.save
        token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')
        render json: { token:, first_name: @user.first_name, message: 'User was created successfully!',
                       data: @user }, status: :ok
      else
        response_422(@user, 'Failed to save user. Please try again later')
      end
    end

    def update
      return unless @user.present?

      @user.update(user_params)
      response_200('User was updated sucessfully', @user)
    end

    def destroy
      return unless @user.present?

      @user.destroy
      response_200('User was delete successfully')
    end

    private

    def find_user
      @user = User.find_by!(id: params[:id])
    rescue ActiveRecord::RecordNotFound
      response_400('User not found')
    end

    def user_params
      params.permit(
        :first_name, :last_name, :age, :dob, :email, :password, :password_confirmation
      )
    end
  end
end
