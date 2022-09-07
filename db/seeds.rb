# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pirate = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
clawdia = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
lucille = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

billy = Applicant.create(first_name: "Billy",
                          last_name: "Jameson",
                          street_address: '123 Royal Lane',
                          city: "Denver",
                          state: "CO",
                          zipcode: 80205,
                          status: "Pending")

johnny = Applicant.create(first_name: "Johnny",
                          last_name: "Maybach",
                          street_address: '456 Froot Loop Way',
                          city: "Mattoon",
                          state: "IL",
                          zipcode: 54242,
                          status: "Pending")

PetApplication.create(pet: @pirate, applicant: @billy)
PetApplication.create(pet: @clawdia, applicant: @johnny)
PetApplication.create(pet: @lucille, applicant: @johnny)


# applicant1 = Applicant.create(first_name: "bobby", last_name: "jones", street_address: '909 Winding way', city: "Louisville", state: "colorado", zipcode: '81212', description: "I like turtles", status: "In Progress")
