module Api::V1
  class AuthenticationController < ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authorize_request, only: :login

    def login
      @user = User.find_by_email(params[:authentication][:email])
      if @user&.valid_password?(params[:authentication][:password])
        token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')
        user = UserSerializer.new(@user).serializable_hash[:data]
        response_200('Login Sucessfully', { token:, user: })
      else
        response_401('Invalid Email or Password')
      end
    end
  end
end
