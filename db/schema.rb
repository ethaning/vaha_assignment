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

ActiveRecord::Schema.define(version: 2021_01_21_004735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "expertises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trainee_trainers", force: :cascade do |t|
    t.bigint "trainee_id", null: false
    t.bigint "trainer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trainee_id"], name: "index_trainee_trainers_on_trainee_id"
    t.index ["trainer_id"], name: "index_trainee_trainers_on_trainer_id"
  end

  create_table "trainee_workouts", force: :cascade do |t|
    t.bigint "trainee_id", null: false
    t.bigint "workout_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trainee_id"], name: "index_trainee_workouts_on_trainee_id"
    t.index ["workout_id"], name: "index_trainee_workouts_on_workout_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "type"
    t.bigint "expertise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expertise_id"], name: "index_users_on_expertise_id"
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.bigint "creator_id", null: false
    t.integer "duration"
    t.integer "state", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_workouts_on_creator_id"
  end

  add_foreign_key "trainee_trainers", "users", column: "trainee_id"
  add_foreign_key "trainee_trainers", "users", column: "trainer_id"
  add_foreign_key "trainee_workouts", "users", column: "trainee_id"
  add_foreign_key "trainee_workouts", "workouts"
  add_foreign_key "users", "expertises"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workouts", "users", column: "creator_id"
end
