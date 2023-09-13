module SlaveService
  class Index < ApplicationService
    attr_reader :current_user, :mesh_id
    
    def initialize(current_user, mesh_id = nil)
      @current_user = current_user
      @mesh_id = mesh_id
    end
    
    def call
      slaves = current_user.slaves
      slaves = slaves.where(mesh_id: mesh_id) if mesh_id
      return success(slaves)
      rescue => e
        return failure(e)
    end
  
    def self.call(current_user:, mesh_id:)
      new(current_user, mesh_id).call
    end
  end
end