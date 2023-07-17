class AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = generate_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def verify
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = decode_token(token)

    if decoded_token
      user = User.find(decoded_token['user_id'])
      render json: { user: user }
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def generate_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secrets.secret_key_base)
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)&.first
  rescue JWT::DecodeError
    nil
  end
end
