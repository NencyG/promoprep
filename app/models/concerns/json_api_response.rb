module JsonApiResponse
  extend ActiveSupport::Concern

  def response_200(message, data)
    render json: { status: 200, errors: [], message:, data: }, status: :ok
  end

  def response_400(message, data = {})
    render json: { status: 400, errors: [], message:, data: }, status: :bad_request
  end

  def response_201(message, data)
    render json: { status: 201, errors: [], message:, data: }, status: :create
  end

  def response_422(error_messages, message)
    render json: { status: 422, errors: error_messages, message:, data: {} }, status: :unprocessable_entity
  end

  def response_401(error_messages)
    render json: { status: 401, errors: error_messages, message: [], data: {} }, status: :unauthorized
  end
end
