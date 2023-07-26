puts "loaded"
module Api
  module V0
    class CreateMeshService
      include Interactor

      def call
        puts "create a mesh"
        puts "context #{context}"
      end
    end
  end
end