# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(foster_program: true, name: "Fur Babys R US", city: "Phoenix", rank: 1)
shelter_2 = Shelter.create(foster_program: true, name: "Tiny Paws", city: "Denver", rank: 3)

shelter_1.pets.create!(adoptable: true, age: 1, breed: "dog", name: "Oliver")
shelter_1.pets.create!(adoptable: true, age: 6, breed: "dog", name: "Sadie")
shelter_1.pets.create!(adoptable: true, age: 4, breed: "cat", name: "DC")

shelter_2.pets.create!(adoptable: true, age: 10, breed: "dog", name: "Sebastian")
shelter_2.pets.create!(adoptable: true, age: 14, breed: "cat", name: "Jasmine")
shelter_2.pets.create!(adoptable: true, age: 2, breed: "dog", name: "Tonks")