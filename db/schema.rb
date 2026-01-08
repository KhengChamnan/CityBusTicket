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

ActiveRecord::Schema[8.1].define(version: 2026_01_08_044633) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "bus_schedule_id", null: false
    t.datetime "created_at", null: false
    t.integer "number_of_seats"
    t.string "passenger_email"
    t.string "passenger_name"
    t.integer "status"
    t.decimal "total_price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["bus_schedule_id"], name: "index_bookings_on_bus_schedule_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "bus_schedules", force: :cascade do |t|
    t.datetime "arrival_time"
    t.integer "available_seats"
    t.bigint "bus_id", null: false
    t.datetime "created_at", null: false
    t.datetime "departure_time"
    t.bigint "route_id", null: false
    t.decimal "seat_price"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["bus_id"], name: "index_bus_schedules_on_bus_id"
    t.index ["route_id"], name: "index_bus_schedules_on_route_id"
  end

  create_table "buses", force: :cascade do |t|
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.string "model"
    t.string "plate_number"
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.string "payment_method"
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "destination_province_id"
    t.decimal "distance_km"
    t.integer "duration_min"
    t.integer "origin_province_id"
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "credit"
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "bookings", "bus_schedules"
  add_foreign_key "bookings", "users"
  add_foreign_key "bus_schedules", "buses"
  add_foreign_key "bus_schedules", "routes"
  add_foreign_key "payments", "bookings"
  add_foreign_key "sessions", "users"
end
