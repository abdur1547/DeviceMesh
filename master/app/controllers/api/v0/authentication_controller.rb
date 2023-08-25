# frozen_string_literal: true

module Api
  module V0
    class AuthenticationController < ApplicationController
      def login
        user = User.find_by(email: login_params[:email])

        if user&.authenticate(login_params[:password])
          token = JwtService::Encoder.call(user)
          render json: { token: token }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      def signup
        user = User.new(signup_params)

        if user.create
          token = JwtService::Encoder.call(user)
          render json: { token: token }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      private
      def login_params
        params.permit(:email, :password)
      end

      def signup_params
        params.permit(:email, :password, :full_name, :password_digest)
      end
    end
  end
end
