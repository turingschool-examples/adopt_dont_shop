# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter = Shelter.create({name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9})

Pet.create(adoptable: true, age: 2, breed: 'Shih-Poo', name: 'Frankie', shelter_id: @shelter.id)
Pet.create(adoptable: true, age: 1, breed: 'Cavapoo', name: 'Fiona', shelter_id: @shelter.id)