# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180305101935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "alarms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "network_service_id"
    t.bigint "vnf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_service_id"], name: "index_alarms_on_network_service_id"
    t.index ["vnf_id"], name: "index_alarms_on_vnf_id"
  end

  create_table "network_services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pops", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.string "instance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rrhs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "model"
    t.string "ip"
    t.string "version"
    t.float "latitude"
    t.float "longitude"
    t.bigint "scenario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scenario_id"], name: "index_rrhs_on_scenario_id"
  end

  create_table "scenarios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scripts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.text "configuration"
    t.bigint "vnf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vnf_id"], name: "index_scripts_on_vnf_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vnfs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "cores", null: false
    t.integer "ram", null: false
    t.integer "disc", null: false
    t.string "url_server"
    t.string "url_monitoring"
    t.string "url_logging"
    t.string "status", default: "Shut Down", null: false
    t.text "command"
    t.bigint "network_service_id"
    t.bigint "pop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_service_id"], name: "index_vnfs_on_network_service_id"
    t.index ["pop_id"], name: "index_vnfs_on_pop_id"
  end

end
