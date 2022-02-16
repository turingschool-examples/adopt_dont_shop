# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
pet_2 = shelter_2.pets.create!(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_3.pets.create!(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)
pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

app_1 = Application.create!(
  name: "Jerry Blank",
  street_address: "246 DumDum Ave.",
  city: "Melbourne",
  state: "IL",
  zip_code: 53262,
  status: "In Progress"
)
app_2 = Application.create!(
  name: "Jeff Jippers",
  street_address: "123 Affirmative Ave.",
  city: "Claytown",
  state: "AL",
  zip_code: 34567,
  status: "Pending"
)
app_3 = Application.create!(
  name: "Michael Jackson",
  street_address: "123 Main St.",
  city: "Basicville",
  state: "OH",
  zip_code: 12345,
  status: "In Progress"
)
PetApplication.create!(pet_id: pet_1.id, application_id: app_2.id)
PetApplication.create!(pet_id: pet_3.id, application_id: app_2.id)
PetApplication.create!(pet_id: pet_1.id, application_id: app_1.id)
PetApplication.create!(pet_id: pet_2.id, application_id: app_1.id)
