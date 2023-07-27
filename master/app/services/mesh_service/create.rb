module MeshService
  class Create < ApplicationService
    attr_reader :name, :current_user
    
    def initialize(name, current_user)
      @name = name
      @current_user = current_user
    end
    
    def call
      mesh = Mesh.create!(name: name, user_id: current_user.id)
      return success(mesh)
      rescue => e
        return failure(e)
    end
  
    def self.call(name:, current_user:)
      new(name, current_user).call
    end
  end
end