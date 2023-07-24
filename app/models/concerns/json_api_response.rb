module JsonApiResponse
  extend ActiveSupport::Concern

  def response_200(message, data)
    render json: { status: 200, error: [], message: message, data: data}, status: :ok
  end

  def render_api_response(status, message, data)
    render json: { status:, message:, data: }, status:
  end

  def render_api_errorsmessage(data)
    render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
  end

  def not_found(message)
    render json: { message: }, status: :bad_request
  end
end
