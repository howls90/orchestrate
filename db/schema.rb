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

ActiveRecord::Schema.define(version: 20180224064914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"

  create_table "alarms", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "vnf_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "network_services", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pops", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.string "instance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rrhs", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "model"
    t.string "ip"
    t.string "version"
    t.float "latitude"
    t.float "longitude"
    t.uuid "scenario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scenarios", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scripts", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.text "configuration"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vnfs", id: :uuid, default: -> { "uuid_generate_v1()" }, force: :cascade do |t|
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
    t.uuid "network_service_id"
    t.uuid "pop_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
