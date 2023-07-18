class CreateMeshes < ActiveRecord::Migration[7.0]
  def change
    create_table :meshes do |t|
      t.string :name, null: false, default: ""
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :meshes, [:user_id, :name], unique: true
  end
end
