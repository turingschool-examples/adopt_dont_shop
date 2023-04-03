# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

@shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 5)
@shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 1)

@pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
@pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
@pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)

@pet_1.applications.create!(
  name: "Billy Mays",
  street_address:  "123 Main St",
  city: "Aurora",
  state: "CO",
  zip: "80012",
  status: "In Progress",
  description: "I like pets",
)

Application.create!(
name: "John Mayer",
street_address:  "777 Fake Ave",
city: "New York",
state: "NY",
zip: "77777",
status: "In Progress",
description: "I am the best!",
)

Application.create!(
name: "Jorge King",
street_address:  "333 Round Blvd.",
city: "Sacramento",
state: "CA",
zip: "90071",
status: "In Progress",
description: "I LOVE pets",
)

# ShelterVeterinarian.destroy_all
# Shelter.destroy_all
