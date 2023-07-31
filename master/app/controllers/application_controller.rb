class ApplicationController < ActionController::API
  before_action :authenticate_user

  rescue_from StandardError do |exception|
    case exception.class.name
    when ActiveRecord::RecordInvalid.name then unprocessable_entity(exception.message)
    # when Pagy::VariableError.name then process_pagy_error(exception)
    # when Pundit::NotAuthorizedError.name then unauthorized_response
    else process_standard_error(exception)
    end
  end

  private

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = decode_token(token)

    if decoded_token
      @current_user = User.find(decoded_token['user_id'])
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def decode_token(token)
    JWT.decode(token, ENV['SECRET_KEY_BASE'])&.first
  rescue JWT::DecodeError
    nil
  end

  def current_user
    @current_user
  end

  def process_standard_error(exception)
    render json: { errors: [{ base: [exception.message] }] }, status: :internal_server_error
  end

  def unauthorized_response(reason = 'You are unauthorized to view this resource')
    render json: { errors: [{ base: [reason] }] }, status: :unauthorized
  end

  def unprocessable_entity(error_message)
    render json: { errors: [{ base: [error_message] }] }, status: :unprocessable_entity
  end

  def process_pagy_error(exception)
    render json: { errors: [{ base: [exception.message] }] }, status: :unprocessable_entity
  end
end
