module SlaveService
  class Show < ApplicationService
    attr_reader :id, :current_user
    
    def initialize(id, current_user)
      @id = id
      @current_user = current_user
    end
    
    def call
      slave = Slave.find_by!(id: id)
      return success(slave)
      rescue => e
        return failure(e)
    end
  
    def self.call(id:, current_user:)
      new(id, current_user).call
    end
  end
end