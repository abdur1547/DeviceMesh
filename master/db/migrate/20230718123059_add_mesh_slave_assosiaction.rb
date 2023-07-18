class AddMeshSlaveAssosiaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :slaves, :mesh, foreign_key: true
    add_index :slaves, [:mesh_id, :name], unique: true
  end
end
