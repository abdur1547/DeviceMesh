module Api
  module V0
    class SlavesController < ApiController
      def index
        result = SlaveService::Index.call(current_user: current_user, mesh_id: params[:mesh_id])
        return success_json_response(data: result[:data], serializer: Api::V0::SlaveSerializer,status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      def create
        result = SlaveService::Create.call(name: mesh_params[:name], current_user: current_user, mesh_id: params[:mesh_id])
        return success_json_response(data: result[:data], serializer: Api::V0::SlaveSerializer,status: :created ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: 403)
      end
    
      def show
        result = SlaveService::Show.call(id: params[:id], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::SlaveSerializer, status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      def update
        result = SlaveService::Update.call(id: params[:id], name: params[:name], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::SlaveSerializer, status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      def destroy
        result = SlaveService::Destroy.call(id: params[:id], current_user: current_user)
        return success_json_response(data: result[:data], serializer: Api::V0::SlaveSerializer, status: :ok ) if result[:success?]
        return failure_json_response(errors: result[:errors], status: :not_found)
      end
    
      private
      def mesh_params
        params.permit(:name)
      end
    end
    
  end
end