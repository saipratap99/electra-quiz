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

ActiveRecord::Schema.define(version: 2021_04_15_191738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "options", force: :cascade do |t|
    t.string "option"
    t.boolean "is_image", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.integer "ans"
    t.string "ques_type"
    t.integer "level"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_questions", force: :cascade do |t|
    t.boolean "is_attempted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "option_id"
    t.bigint "question_id", null: false
    t.index ["option_id"], name: "index_user_questions_on_option_id"
    t.index ["question_id"], name: "index_user_questions_on_question_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "year"
    t.string "branch"
    t.string "regno"
    t.string "phone"
    t.string "email", null: false
    t.string "password"
    t.string "appears_for"
    t.string "role", default: "participant"
    t.datetime "password_sent_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "options", "questions"
  add_foreign_key "user_questions", "options"
  add_foreign_key "user_questions", "questions"
end
