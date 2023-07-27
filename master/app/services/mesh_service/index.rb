module MeshService
  class Index < ApplicationService
    attr_reader :current_user
    
    def initialize(current_user)
      @current_user = current_user
    end
    
    def call
      meshes = Mesh.where(user_id: current_user.id)
      return success(meshes)
      rescue => e
        return failure(e)
    end
  
    def self.call(current_user:)
      new(current_user).call
    end
  end
end