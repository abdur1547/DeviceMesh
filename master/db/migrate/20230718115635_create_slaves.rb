class CreateSlaves < ActiveRecord::Migration[7.0]
  def change
    create_table :slaves do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end
    add_index :slaves, :name, unique: true
  end
end
