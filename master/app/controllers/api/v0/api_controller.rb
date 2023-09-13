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
        failure_json_response(errors: { message: exception.message }, status: :unprocessable_entity)
      end

      def process_standard_error(exception)
        render json: { errors: [{ base: [exception.message] }] }, status: :internal_server_error
      end

      def check_headers
        unauthorized_response if request.headers['jwt'].blank?
      end

      def decode_jwt
        @data = JwtService::Decoder.call(request.headers['jwt'])
        unauthorized_response if @data.blank?
      end

      def current_user
        return if @data.blank? || @data['user_id'].blank?

        @current_user ||= User.find_by(id: @data['user_id'])
      end

      def authenticate_user
        unauthorized_response unless current_user
      end

      def unauthorized_response(error_message = 'You are unauthorized to view this resource')
        failure_json_response(errors: { message: error_message }, status: :unauthorized)
      end

      def not_found_response(error_message = 'The requested resource does not exist')
        failure_json_response(errors: { message: error_message }, status: :not_found)
      end

      def unprocessable_entity(error_message)
        failure_json_response(errors: { message: error_message }, status: :not_found)
      end

      def forbidden_response
        head :forbidden
      end
      
    end
  end
end
