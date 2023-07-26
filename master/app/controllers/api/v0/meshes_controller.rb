class Api::V0::MeshesController < ApplicationController
  def index
  end

  def create
    result = MeshService::Create.call
    puts result
    # puts result.data
    puts result.success?
    puts result.failure?
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def mesh_params
    params.permit(:name)
  end
end
