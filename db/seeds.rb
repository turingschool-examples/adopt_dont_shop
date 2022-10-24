# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_1.pets.create!(adoptable: true, age: 4, breed: "Rotweiller", name: "Raider")
shelter_1.pets.create!(adoptable: true, age: 99, breed: "Chihuahua", name: "Yoda")

Applicant.create!(name: "Pink Floyd", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", good_fit: "I am a Judgy Motha")

