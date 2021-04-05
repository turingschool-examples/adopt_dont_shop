# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create!(foster_program: true, name: "Portland Animal Rescue", city: "Portland, OR", rank: 1)
Pet.create!(name: "Cowboy", age: 1, adoptable: true, breed: "russian blue", shelter_id: shelter_1.id)


#   t.boolean "adoptable"
#     t.integer "age"
#     t.string "breed"
#     t.string "name"
#     t.bigint "shelter_id", null: false
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["shelter_id"], name: "index_pets_on_shelter_id"


#       create_table "shelters", force: :cascade do |t|
#     t.boolean "foster_program"
#     t.string "name"
#     t.string "city"
#     t.integer "rank"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

