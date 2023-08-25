# frozen_string_literal: true

module Api
  module V0
    class ApiController < ApplicationController
      include Pagy::Backend
      include Pundit::Authorization

      before_action :check_headers, :decode_jwt, :authenticate_user

      rescue_from StandardError do |exception|
        case exception.class.name
        when ActiveRecord::RecordInvalid.name then unprocessable_entity(exception.message)
        when Pagy::VariableError.name then process_pagy_error(exception)
        when Pundit::NotAuthorizedError.name then unauthorized_response
        else process_standard_error(exception)
        end
      end

      private

      def process_pagy_error(exception)
        render json: { errors: [{ base: [exception.message] }] }, status: :unprocessable_entity
      end

      def process_standard_error(exception)
        render json: { errors: [{ base: [exception.message] }] }, status: :internal_server_error
      end

      def check_headers
        unauthorized_response if request.headers['jwt'].blank?
      end

      def decode_jwt
        @data = JwtDecoder.call(request.headers['jwt'])
        unauthorized_response if @data.blank?
      end

      def current_user
        return if @data.blank? || @data['user_id'].blank?

        @current_user ||= User.find_by(external_id: @data['user_id'], external_type: PARTNERS_AUTH_HASH[@data['requester_token']])
      end

      def authenticate_user
        unauthorized_response unless current_user
      end

      def unauthorized_response(reason = 'You are unauthorized to view this resource')
        render json: { errors: [{ base: [reason] }] }, status: :unauthorized
      end

      def not_found_response(reason = 'The requested resource does not exist')
        render json: { errors: [{ base: [reason] }] }, status: :not_found
      end

      def unprocessable_entity(error_message)
        render json: { errors: [{ base: [error_message] }] }, status: :unprocessable_entity
      end

      def forbidden_response
        head :forbidden
      end
      
    end
  end
end
