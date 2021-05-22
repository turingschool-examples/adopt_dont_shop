# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
shelter_1.pets.create!(name: 'Pet 1', breed: 'tuxedo shorthair', age: 5, adoptable: true)
shelter_1.pets.create!(name: 'Pet 2', breed: 'shorthair', age: 3, adoptable: true)
shelter_3.pets.create!(name: 'Pet 3', breed: 'sphynx', age: 8, adoptable: true)