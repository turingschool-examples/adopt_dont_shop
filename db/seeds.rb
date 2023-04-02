# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetsApplication.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

@shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
@pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
@pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Doggo', shelter_id: @shelter.id)
@pet_5 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Dingo', shelter_id: @shelter.id)
@pet_6 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Rufus', shelter_id: @shelter.id)
@pet_7 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Rufus', shelter_id: @shelter.id)
@pet_8 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Dawg', shelter_id: @shelter.id)
@pet_9 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Dog', shelter_id: @shelter.id)

@app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
@app_2 = Application.create!(name: 'Franklin', address: '611 Wallow Ct', city: 'Santa Fe', state: 'NM', zip: '87508', description: 'Lonely guy with hella money', status: "In Progress")

PetApplication.create!(application: @app_1, pet: @pet_5)
PetApplication.create!(application: @app_2, pet: @pet_7)