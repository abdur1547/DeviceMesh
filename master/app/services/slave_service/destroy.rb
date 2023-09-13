module SlaveService
  class Destroy < ApplicationService
    attr_reader :id, :current_user
    
    def initialize(id, current_user)
      @id = id
      @current_user = current_user
    end
    
    def call
      mesh = Mesh.find_by!(id: id)
      return success(mesh) if mesh.destroy!
      rescue => e
        return failure(e)
    end
  
    def self.call(id:, current_user:)
      new(id, current_user).call
    end
  end
end