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

ActiveRecord::Schema.define(version: 20171118121103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_devices_on_space_id"
    t.index ["token"], name: "index_devices_on_token", unique: true
  end

  create_table "image_metadata", force: :cascade do |t|
    t.integer "image_id", null: false
    t.integer "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id", "key"], name: "index_image_metadata_on_image_id_and_key", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "space_id", null: false
    t.datetime "timestamp"
    t.index ["space_id"], name: "index_images_on_space_id"
    t.index ["timestamp"], name: "index_images_on_timestamp"
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "space_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_permissions_on_space_id"
    t.index ["user_id", "space_id"], name: "index_permissions_on_user_id_and_space_id", unique: true
  end

  create_table "space_settings", force: :cascade do |t|
    t.bigint "space_id"
    t.string "slack_incoming_webhook_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id"], name: "index_space_settings_on_space_id", unique: true
  end

  create_table "spaces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visibility", default: 0, null: false
    t.index ["name"], name: "index_spaces_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
