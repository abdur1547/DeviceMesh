class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.string :name, null: false, default: ""
      t.boolean :status, null: false, default: false
      t.references :slave, foreign_key: true

      t.timestamps
    end

    add_index :pins, [:slave_id, :name], unique: true
  end
end
