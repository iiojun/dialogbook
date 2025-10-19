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

ActiveRecord::Schema[8.0].define(version: 2025_10_14_212337) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_lessons_on_school_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.datetime "start_date"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_meetings_on_project_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.bigint "user_id", null: false
    t.string "title"
    t.text "message"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_notes_on_meeting_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.text "body"
    t.boolean "need_response", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_posts_on_lesson_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rubrics", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.string "item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_rubrics_on_lesson_id"
  end

  create_table "schools", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name"
    t.string "address"
    t.string "code"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_schools_on_project_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "rubric_id", null: false
    t.bigint "user_id", null: false
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rubric_id"], name: "index_scores_on_rubric_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.text "title"
    t.text "memo"
    t.boolean "done", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_todos_on_project_id"
  end

  create_table "user_schools", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "school_id", null: false
    t.boolean "registered", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_user_schools_on_school_id"
    t.index ["user_id"], name: "index_user_schools_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.string "name"
    t.string "role", default: "student", null: false
    t.string "nickname"
    t.string "picture"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "lessons", "schools"
  add_foreign_key "meetings", "projects"
  add_foreign_key "notes", "meetings"
  add_foreign_key "notes", "users"
  add_foreign_key "posts", "lessons"
  add_foreign_key "posts", "users"
  add_foreign_key "rubrics", "lessons"
  add_foreign_key "schools", "projects"
  add_foreign_key "scores", "rubrics"
  add_foreign_key "scores", "users"
  add_foreign_key "todos", "projects"
  add_foreign_key "user_schools", "schools"
  add_foreign_key "user_schools", "users"
  add_foreign_key "users", "schools"
end
