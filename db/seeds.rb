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

shelter_1 = Shelter.create(
  name: "Aurora City Shelter",
  city: Faker::Address.city,
  foster_program: false,
  rank: Faker::Number.between(from: 1, to: 9)
)
shelter_2 = Shelter.create(
  name: "RGV animal shelter",
  city: Faker::Address.city,
  foster_program: false,
  rank: Faker::Number.between(from: 1, to: 9)
)
shelter_3 = Shelter.create(
  name: "Boulder Valley Shelter",
  city: Faker::Address.city,
  foster_program: false,
  rank: Faker::Number.between(from: 1, to: 9)
)

10.times do
  Pet.create!(
    name: Faker::Creature::Dog.name,
    breed: Faker::Creature::Dog.breed,
    adoptable: true,
    age: Faker::Number.between(from: 1, to: 10),
    shelter_id: shelter_1.id
  )
end

10.times do
  Pet.create!(
    name: Faker::Creature::Dog.name,
    breed: Faker::Creature::Dog.breed,
    adoptable: true,
    age: Faker::Number.between(from: 1, to: 10),
    shelter_id: shelter_2.id
  )
end

10.times do
  Pet.create!(
    name: Faker::Creature::Dog.name,
    breed: Faker::Creature::Dog.breed,
    adoptable: true,
    age: Faker::Number.between(from: 1, to: 10),
    shelter_id: shelter_3.id
  )
end

puts "Created #{Shelter.count} Shelters and #{Pet.count} pets."
