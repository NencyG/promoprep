module Api::V1
  class AuthenticationController < ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorize_request, only: :login

    def login
      @user = User.find_by_email(params[:email])
      if @user&.valid_password?(params[:password])
        token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')
        login_response(token, 'Login Sucessfully', @user)
      else
        response_401('Invalid Email or Password')
      end
    end

    private

    def login_params
      params.require(:user).permit(:email, :password)
    end
  end
end
