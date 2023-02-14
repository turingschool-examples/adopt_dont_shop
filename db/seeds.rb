# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shelter.destroy_all
Pet.destroy_all
Application.destroy_all

shelter_1 = Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1")
shelter_2 = Shelter.create!(name: "Humane Society", foster_program: false, city: "Aurora", rank: "2")
shelter_3 = Shelter.create!(name: "Max Fund", foster_program: true, city: "Denver", rank: "3")

pet_1 = Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry")
pet_2 = Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 1, breed: "Boston Terrier", name: "Max")
pet_3 = Pet.create!(shelter_id: shelter_1.id, adoptable: false, age: 4, breed: "Soft Coated Wheaton Terrier", name: "Daisy")

pet_4 = Pet.create!(shelter_id: shelter_2.id, adoptable: false, age: 4, breed: "Pit Bull", name: "Sally")
pet_5 = Pet.create!(shelter_id: shelter_2.id, adoptable: false, age: 3, breed: "Poodle", name: "Joey")
pet_6 = Pet.create!(shelter_id: shelter_2.id, adoptable: true, age: 2, breed: "Golden Retriever", name: "Spot")

pet_7 = Pet.create!(shelter_id: shelter_3.id, adoptable: false, age: 4, breed: "Soft Coated Wheaton Terrier", name: "Sal")
pet_8 = Pet.create!(shelter_id: shelter_3.id, adoptable: true, age: 2, breed: "Golden Doodle", name: "Barbara")
pet_9 = Pet.create!(shelter_id: shelter_3.id, adoptable: true, age: 1, breed: "French Bull Dog", name: "Gabby")

application_1 = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, description: "I love them", pets_on_app: "Daisy, Sal", app_status: "Accepted")