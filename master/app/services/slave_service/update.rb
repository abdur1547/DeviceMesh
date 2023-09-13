module SlaveService
  class Update < ApplicationService
    attr_reader :id, :name, :current_user
    
    def initialize(id, name, current_user)
      @id = id
      @name = name
      @current_user = current_user
    end
    
    def call
      mesh = Slave.find_by!(id: id)
      return success(mesh) if mesh.update!(name: name)
      rescue => e
        return failure(e)
    end
  
    def self.call(id:, name:, current_user:)
      new(id, name, current_user).call
    end
  end
end