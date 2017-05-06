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

ActiveRecord::Schema.define(version: 20170506011443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_keys", force: :cascade do |t|
    t.string "access_key_id"
    t.string "encrypted_secret_access_key"
    t.string "encrypted_secret_access_key_iv"
    t.integer "max_strikes"
    t.integer "max_sieges"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_key_id"], name: "index_access_keys_on_access_key_id"
  end

  create_table "attackers", force: :cascade do |t|
    t.integer "siege_id"
    t.string "username"
    t.string "encrypted_password"
    t.string "encrypted_password_iv"
    t.string "username_field"
    t.string "password_field"
    t.string "new_session_url"
    t.text "cookie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "create_session_url"
    t.index ["siege_id"], name: "index_attackers_on_siege_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "status"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "volley_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "target_id"
    t.integer "code"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "volley_id"
    t.index ["target_id"], name: "index_results_on_target_id"
  end

  create_table "sieges", force: :cascade do |t|
    t.integer "access_key_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["access_key_id"], name: "index_sieges_on_access_key_id"
  end

  create_table "targets", force: :cascade do |t|
    t.integer "siege_id"
    t.integer "attacker_id"
    t.integer "priority"
    t.string "method"
    t.text "url"
    t.text "body"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "authenticated", default: true
    t.datetime "locked_at"
    t.index ["attacker_id"], name: "index_targets_on_attacker_id"
    t.index ["siege_id"], name: "index_targets_on_siege_id"
  end

  create_table "volleys", force: :cascade do |t|
    t.integer "siege_id"
    t.string "name"
    t.string "status"
    t.integer "strikes"
  end

end
