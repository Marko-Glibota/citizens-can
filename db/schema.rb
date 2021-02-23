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

ActiveRecord::Schema.define(version: 2021_02_23_115217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.string "voting_status"
    t.bigint "user_id", null: false
    t.bigint "law_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["law_id"], name: "index_comments_on_law_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "districts", force: :cascade do |t|
    t.integer "department_code"
    t.string "department_name"
    t.integer "district_num"
    t.decimal "district_coordinates"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "laws", force: :cascade do |t|
    t.integer "num"
    t.text "title"
    t.text "description"
    t.integer "representative_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "representatives", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "salutation"
    t.string "email"
    t.string "circonscription_ref"
    t.string "circonscription_num"
    t.string "city"
    t.string "department"
    t.string "region"
    t.string "party"
    t.string "representative_ref"
    t.boolean "first_election"
    t.integer "hemicycle_seat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "representatives_votes", force: :cascade do |t|
    t.bigint "representative_id", null: false
    t.string "voting_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "law_id", null: false
    t.index ["law_id"], name: "index_representatives_votes_on_law_id"
    t.index ["representative_id"], name: "index_representatives_votes_on_representative_id"
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
    t.string "address"
    t.string "zip"
    t.string "city"
    t.integer "age"
    t.bigint "representative_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["representative_id"], name: "index_users_on_representative_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_votes", force: :cascade do |t|
    t.string "voting_status"
    t.bigint "law_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["law_id"], name: "index_users_votes_on_law_id"
    t.index ["user_id"], name: "index_users_votes_on_user_id"
  end

  add_foreign_key "comments", "laws"
  add_foreign_key "comments", "users"
  add_foreign_key "representatives_votes", "laws"
  add_foreign_key "representatives_votes", "representatives"
  add_foreign_key "users", "representatives"
  add_foreign_key "users_votes", "laws"
  add_foreign_key "users_votes", "users"
end
