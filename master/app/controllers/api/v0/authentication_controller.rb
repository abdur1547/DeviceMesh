# frozen_string_literal: true

module Api
  module V0
    class AuthenticationController < ApplicationController
      def login
        user = User.find_by(email: login_params[:email])

        if user&.authenticate(login_params[:password])
          token = JwtService::Encoder.call(user)
          success_json_response(data: {token: token}, status: :created)
        else
          failure_json_response(errors: "Invalid credentials", status: :unauthorized)
        end
      end

      def signup
        user = User.new(signup_params)

        if user.save
          token = JwtService::Encoder.call(user)
          success_json_response(data: { token: token, user:  user}, status: :created)
        else
          failure_json_response(errors: user.errors.full_messages, status: :unauthorized)
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
