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

  def response_422(data, message)
    render json: { status: 422, errors: data.errors.full_messages, message:, data: {} }, status: :unprocessable_entity
  end
end
