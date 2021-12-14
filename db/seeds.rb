# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create!(name: "Buster", adoptable: true, age: 2, breed: "Black Lab")
@pet_2 = @shelter_2.pets.create!(name: "Minnie", adoptable: false, age: 2, breed: "Chow")
@pet_3 = @shelter_2.pets.create!(name: "Busted", adoptable: true, age: 6, breed: "Bulldog")

@application = Application.create!(
  name: "Joel Grant",
  street_address: "1234 Grant Road",
  city: "Littleton",
  state: "Colorado",
  zip: "80120"
)
@application_2 = Application.create!(
  name: "Peter Griffin",
  street_address: "1098 Spooner Street",
  city: "Quahog",
  state: "Rhode Island",
  zip: "12345"
)
ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
