# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'Stupid Friends League', city: 'Dumbville, CO', foster_program: false, rank: 8)

shelter_1.pets.create!(adoptable: true, age: 4, breed: "Rotweiller", name: "Raider")
shelter_1.pets.create!(adoptable: true, age: 99, breed: "Chihuahua", name: "Yoda")
shelter_1.pets.create!(adoptable: true, age: 24, breed: "Hedgehog", name: "Sonic")
shelter_2.pets.create!(adoptable: true, age: 6, breed: "German Shepherd", name: "Fritz")
shelter_2.pets.create!(adoptable: true, age: 7, breed: "Chia Pet", name: "Snooky")
shelter_2.pets.create!(adoptable: true, age: 7, breed: "Cat", name: "Fritz")

Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309")
Applicant.create!(name: "The Burger King", street_address: "88 Cheeze Lane", city: "Mymouth", state: "CO", zip: "092347")
Applicant.create!(name: "Fox Mulder", street_address: "987 Believe Ct", city: "undisclosed", state: "DC", zip: "000000")

