# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_08_081103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", id: :serial, force: :cascade do |t|
    t.string "followable_type", null: false
    t.integer "followable_id", null: false
    t.string "follower_type", null: false
    t.integer "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "show_id", null: false
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
    t.index ["show_id"], name: "index_performances_on_show_id"
  end

  create_table "planners", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "performance_id"
    t.string "top"
    t.string "duration"
    t.datetime "day"
    t.index ["performance_id"], name: "index_planners_on_performance_id"
    t.index ["user_id"], name: "index_planners_on_user_id"
  end

  create_table "shortlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["show_id"], name: "index_shortlists_on_show_id"
    t.index ["user_id"], name: "index_shortlists_on_user_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "artist"
    t.string "title"
    t.text "description"
    t.string "genre"
    t.bigint "venue_id", null: false
    t.string "original_image"
    t.string "thumb_image"
    t.string "age_category"
    t.string "warnings"
    t.string "website"
    t.boolean "active"
    t.datetime "updated"
    t.string "twitter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.index ["venue_id"], name: "index_shows_on_venue_id"
  end

  create_table "transitions", force: :cascade do |t|
    t.bigint "planner_to_id"
    t.bigint "planner_from_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["planner_from_id"], name: "index_transitions_on_planner_from_id"
    t.index ["planner_to_id"], name: "index_transitions_on_planner_to_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "space"
    t.string "address"
    t.string "postcode"
    t.float "longitude"
    t.float "latitude"
    t.boolean "wheelchair_access"
    t.text "disabled_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "performances", "shows"
  add_foreign_key "planners", "users"
  add_foreign_key "shortlists", "shows"
  add_foreign_key "shortlists", "users"
  add_foreign_key "shows", "venues"
end
