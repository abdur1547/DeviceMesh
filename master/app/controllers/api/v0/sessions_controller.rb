# frozen_string_literal: true

module Api
  module V0
    class SessionsController < ApiController
      def create
        render json: encoded_jwt.to_json, status: :created
      end

      private

      def encoded_jwt
        exp = Time.now.to_i + Constants::SESSION_LIFETIME
        {
          jwt: Api::V1::JwtEncoder.call(current_user, exp: exp),
          exp: exp
        }
      end
    end
  end
end
