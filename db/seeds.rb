# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.find_or_create_by!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.find_or_create_by!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.find_or_create_by!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet_1 = shelter_1.pets.find_or_create_by!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
pet_2 = shelter_1.pets.find_or_create_by!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_3.pets.find_or_create_by!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_1.pets.find_or_create_by!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
application_1 = Application.find_or_create_by!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
application_1.pets << pet_1
