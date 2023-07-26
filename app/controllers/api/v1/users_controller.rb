module Api::V1
  class UsersController < ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorize_request, only: :create
    before_action :find_user, except: %i[create index]

    def index
      @users = User.all
      @users.present? ? response_200('Fetched all the User Successfully', @users) : response_400('User is not Available')
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
      begin
        @user.save!
        token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')
        render json: { token:, first_name: @user.first_name, message: 'User was created successfully!',
                       data: @user }, status: :ok
      rescue StandardError => e
        response_422(e.message, 'Failed to save user. Please try again Later')
      end
    end

    def update
      if @user.present?
        begin
          @user.update!(user_params)
          response_200('User was Updated Sucessfully', @user)
        rescue StandardError => e
          response_422(e.message, 'Failed to Update the User')
        end
      else
        response_400('User not Found')
      end
    end

    def destroy
      return unless @user.present?

      @user.destroy
      response_200('User was Delete Successfully')
    end

    private

    def find_user
      @user = User.find(id: params[:id])
    rescue ActiveRecord::RecordNotFound
      response_400('User not Found')
    end

    def user_params
      params.permit(
        :first_name, :last_name, :age, :dob, :email, :password, :password_confirmation
      )
    end
  end
end
