module Api
  module V0
    class SalvesController < ApiController
      def index
        result = MeshService::Index.call(current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::MeshSerializer,status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      def create
        result = MeshService::Create.call(name: mesh_params[:name], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::MeshSerializer,status: :created ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: 403)
      end
    
      def show
        result = MeshService::Show.call(id: params[:id], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::MeshSerializer, status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      def update
        result = MeshService::Update.call(id: params[:id], name: params[:name], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::MeshSerializer, status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      def destroy
        result = MeshService::Destroy.call(id: params[:id], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::MeshSerializer, status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      private
      def mesh_params
        params.permit(:name)
      end
    end
    
  end
end