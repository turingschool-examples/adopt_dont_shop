# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter = Shelter.create!(foster_program: true,
              name: "frankie's friendly felines",
              city: "westminster",
              rank: 10)

bean = Pet.create!(
              name: "Bean",
              adoptable: true,
              age: 1,
              breed: "cat",
              shelter_id: shelter.id)

flower = Pet.create!(
              name: "Flower",
              adoptable: true,
              age: 2,
              breed: "skunk",
              shelter_id: shelter.id)
