class ApplicationController < ActionController::API
  def success_json_response(data:, serializer:, status:)
    render json: {success: true, status: status, data: ActiveModelSerializers::SerializableResource.new(data, {serializer: serializer})}, status: status
  end

  def failure_json_response(errors:, status:)
    render json: {success: false, status: status, errors: errors}, status: status
  end
end
