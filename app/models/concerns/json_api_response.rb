module JsonApiResponse
  extend ActiveSupport::Concern

  def response_200(message, data)
    render json: { status: 200, error: [], message:, data: }, status: :ok
  end

  def response_400(message, data = {})
    render json: { status: 400, error: [], message:, data: }, status: :bad_request
  end

  def response_201(message, data)
    render json: { status: 201, error: [], message:, data: }, status: :create
  end

  def response_422(errormessages, message)
    render json: { status: 422, errors: errormessages, message:, data: {} }, status: :unprocessable_entity
  end

  def response_401(errormessages)
    render json: { status: 401, errors: errormessages, message: [], data: {} }, status: :unauthorized
  end

  def login_response(token, message, data)
    render json: { status: 200, token: token, message: message, error: [], data: data }, status: :ok
  end
end
