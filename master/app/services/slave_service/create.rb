module SlaveService
  class Create < ApplicationService
    attr_reader :name, :current_user, :mesh_id
    
    def initialize(name, current_user, mesh_id)
      @name = name
      @current_user = current_user
      @mesh_id = mesh_id
    end
    
    def call
      mesh = Slave.create!(name: name, mesh_id: mesh_id)
      return success(mesh)
      rescue => e
        return failure(e)
    end
  
    def self.call(name:, current_user:, mesh_id:)
      new(name, current_user, mesh_id).call
    end
  end
end