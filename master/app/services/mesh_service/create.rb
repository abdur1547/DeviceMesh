module MeshService
  class Create
    include Interactor

    def call
      puts "create a mesh"
      puts "context #{context}"
    end
  end
end