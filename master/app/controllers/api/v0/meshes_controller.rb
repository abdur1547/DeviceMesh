class Api::V0::MeshesController < ApplicationController
  def index
  end

  def create
    result = MeshService::Create.call(name: mesh_params[:name], current_user: current_user)
    return success_json_response(success: true, data: result[:data], serializer: Api::V0::MeshSerializer,status: :created ) if result[:success?]
    return failure_json_response(errors: result[:errors], status: 403)
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def mesh_params
    params.permit(:name)
  end
end
