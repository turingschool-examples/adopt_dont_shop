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
PetApplication.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

app_1 = Application.create!(name: 'Jes Mae', street_address: '5555 Tattoo St', city: 'Louisville', state: 'KY', zip_code: 40220, status: 'Pending', description: 'Crazy Cat Lady')
app_2 = Application.create!(name: 'Jeremy', street_address: '4050 Corvette Dr', city: 'Bowling Green', state: 'KY', zip_code: 40272, status: 'Approved', description: 'Trying to save them all')
app_3 = Application.create!(name: 'Maggie', street_address: '8888 Hendon Rd', city: 'Louisville', state: 'KY', zip_code: 40220, status: 'Rejected', description: 'I need more!')

pet_app_1 = PetApplication.create!(pet: pet_1, application: app_1)
pet_app_2 = PetApplication.create!(pet: pet_2, application: app_1)
pet_app_3 = PetApplication.create!(pet: pet_3, application: app_2)
pet_app_4 = PetApplication.create!(pet: pet_4, application: app_2)
