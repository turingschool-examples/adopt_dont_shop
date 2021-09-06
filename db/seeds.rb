# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

application = Application.create!(name: "Andrew Massey", street: "4433 Old Forge Dr", city: "Gastonia", state: "NC", zip: 28056, message: "Please pick me")
shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
pet_3 = Pet.create!(adoptable: true, age: 10, breed: 'lab', name: "Lobsterman", shelter_id: shelter.id)
pet_4 = Pet.create!(adoptable: true, age: 8, breed: 'lab', name: "Lobby", shelter_id: shelter.id)
