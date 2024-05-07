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

ActiveRecord::Schema[7.1].define(version: 2024_05_03_165913) do
  create_table "alternatives", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "statement", null: false
    t.string "description"
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_alternatives_on_question_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.integer "quiz_answer_id", null: false
    t.integer "quiz_question_id", null: false
    t.integer "alternative_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alternative_id"], name: "index_question_answers_on_alternative_id"
    t.index ["quiz_answer_id"], name: "index_question_answers_on_quiz_answer_id"
    t.index ["quiz_question_id"], name: "index_question_answers_on_quiz_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "statement", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_answers_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_answers_on_user_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "quiz_id", null: false
    t.integer "position", null: false
    t.integer "weight", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quiz_questions_on_question_id"
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "alternatives", "questions"
  add_foreign_key "question_answers", "alternatives"
  add_foreign_key "question_answers", "quiz_answers"
  add_foreign_key "question_answers", "quiz_questions"
  add_foreign_key "quiz_answers", "quizzes"
  add_foreign_key "quiz_answers", "users"
  add_foreign_key "quiz_questions", "questions"
  add_foreign_key "quiz_questions", "quizzes"
end
