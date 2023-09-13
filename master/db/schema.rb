# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_18_123059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meshes", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_meshes_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_meshes_on_user_id"
  end

  create_table "pins", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "status", default: false, null: false
    t.bigint "slave_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slave_id", "name"], name: "index_pins_on_slave_id_and_name", unique: true
    t.index ["slave_id"], name: "index_pins_on_slave_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", default: "normal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "slaves", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mesh_id"
    t.index ["mesh_id", "name"], name: "index_slaves_on_mesh_id_and_name", unique: true
    t.index ["mesh_id"], name: "index_slaves_on_mesh_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "meshes", "users"
  add_foreign_key "pins", "slaves", column: "slave_id"
  add_foreign_key "slaves", "meshes"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
