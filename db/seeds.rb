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

shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
pet_3 = Pet.create(adoptable: true, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
pet_4 = Pet.create(adoptable: true, age: 6, breed: 'sphynx', name: 'The Right Reverend', shelter_id: shelter.id)
pet_5 = Pet.create(adoptable: true, age: 23, breed: 'doberman', name: 'Quince Essential', shelter_id: shelter.id)
pet_6 = Pet.create(adoptable: true, age: 2, breed: 'saint bernard', name: 'Chunky Monkey', shelter_id: shelter.id)
