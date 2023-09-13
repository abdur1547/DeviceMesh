module SlaveService
  class Index < ApplicationService
    attr_reader :current_user, :mesh_id
    
    def initialize(current_user, mesh_id = nil)
      @current_user = current_user
      @mesh_id = mesh_id
    end
    
    def call
      mesh = current_user.meshes.find_by!(id: mesh_id)
      return success(mesh.slaves)
      rescue => e
        return failure(e)
    end
  
    def self.call(current_user:, mesh_id:)
      new(current_user, mesh_id).call
    end
  end
end