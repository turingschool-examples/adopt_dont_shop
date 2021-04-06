ActiveRecord::Schema.define(version: 2021_04_05_235619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pet_applications", force: :cascade do |t|
    t.bigint "application_id"
    t.bigint "pet_id"
    t.index ["application_id"], name: "index_pet_applications_on_application_id"
    t.index ["pet_id"], name: "index_pet_applications_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.boolean "adoptable"
    t.integer "age"
    t.string "breed"
    t.string "name"
    t.bigint "shelter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.boolean "foster_program"
    t.string "name"
    t.string "city"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "veterinarians", force: :cascade do |t|
    t.boolean "on_call"
    t.integer "review_rating"
    t.string "name"
    t.bigint "veterinary_office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["veterinary_office_id"], name: "index_veterinarians_on_veterinary_office_id"
  end

  create_table "veterinary_offices", force: :cascade do |t|
    t.boolean "boarding_services"
    t.integer "max_patient_capacity"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pet_applications", "applications"
  add_foreign_key "pet_applications", "pets"
  add_foreign_key "pets", "shelters"
  add_foreign_key "veterinarians", "veterinary_offices"
end
