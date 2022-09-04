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

pet_3 = shelter_3.pets.find_or_create_by!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_1.pets.find_or_create_by!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

pet_1 = shelter_1.pets.find_or_create_by!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
pet_2 = shelter_1.pets.find_or_create_by!(adoptable: true, age: 7, breed: 'yorkie', name: 'Mr. Pig')
pet_3 = shelter_2.pets.find_or_create_by!(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill')
pet_4 = shelter_2.pets.find_or_create_by!(adoptable: true, age: 4, breed: 'long hair', name: 'Sweet Potato')
pet_5 = shelter_3.pets.find_or_create_by!(adoptable: true, age: 6, breed: 'Huskey', name: 'Todd')
pet_6 = shelter_3.pets.find_or_create_by!(adoptable: true, age: 2, breed: 'Calico', name: 'Potato Chip')
pet_7 = shelter_3.pets.find_or_create_by!(adoptable: false, age: 5, breed: 'tuxedo shorthair', name: 'Mr. Pirate')
pet_8 = shelter_1.pets.find_or_create_by!(adoptable: true, age: 3, breed: 'shorthair', name: 'Clawdia')

application_1 = Application.find_or_create_by!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "Pending", description: "I'm Lonely")
application_2 = Application.find_or_create_by!(name: "Florence Bigsby", street_address: "202 E Washington Ave", city: "Madison", state: "WI", zipcode: 60637, status: "Pending", description: "I love cats")
application_3 = Application.find_or_create_by!(name: "Todd Matthews", street_address: "620 W 11th St", city: "Hastings", state: "MN", zipcode: 55033, status: "Pending", description: "We have the same name")

application_1.pets << pet_1
application_1.pets << pet_2
application_2.pets << pet_2
application_3.pets << pet_5
