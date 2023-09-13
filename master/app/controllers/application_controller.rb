class ApplicationController < ActionController::API
  def success_json_response(data:, status:, serializer: nil)
    return render json: {success: true, status: status, data: ActiveModelSerializers::SerializableResource.new(data, {each_serializer: serializer})}, status: status if serializer
    render json: {success: true, status: status, data: data}, status: status
  end

  def failure_json_response(errors:, status:)
    render json: {success: false, status: status, errors: errors}, status: status
  end
end
