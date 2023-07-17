class ApplicationController < ActionController::API
  before_action :authenticate_user

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
    JWT.decode(token, Rails.application.secrets.secret_key_base)&.first
  rescue JWT::DecodeError
    nil
  end
end
