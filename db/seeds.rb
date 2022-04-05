# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter3 = Shelter.create!(name: 'Aurora Shelter', city: 'Denver', rank: 4, foster_program: true)
shelter1 = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
shelter2 = Shelter.create!(name: 'Denver Shelter', city: 'Denver', rank: 4, foster_program: true)
pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter1.id)
pet2 = Pet.create!(name: Faker::Creature::Dog.name, age: Faker::Number.between(from: 1, to: 10), breed: Faker::Creature::Dog.breed, adoptable: true, shelter_id: shelter1.id)
pet3 = Pet.create!(name: Faker::Creature::Dog.name, age: Faker::Number.between(from: 1, to: 10), breed: Faker::Creature::Dog.breed, adoptable: true, shelter_id: shelter2.id)
pet4 = Pet.create!(name: Faker::Creature::Dog.name, age: Faker::Number.between(from: 1, to: 10), breed: Faker::Creature::Dog.breed, adoptable: true, shelter_id: shelter2.id)
pet5 = Pet.create!(name: Faker::Creature::Dog.name, age: Faker::Number.between(from: 1, to: 10), breed: Faker::Creature::Dog.breed, adoptable: true, shelter_id: shelter3.id)
application1 = Application.create!(name: 'Andrew',
  street_address: '112 Greenbrook',
  city: 'Denver',
  state: 'CO',
  zipcode: '80207',
  description: 'Happy, friendly, cool',
  status: 'In Progress',
)
application2 = Application.create!(name: 'Antonio',
  street_address: '123 Main St.',
  city: 'Moraga',
  state: 'CA',
  zipcode: '12345',
  description: 'Good home for dogs',
  status: 'Pending',
)
application3 = Application.create!(name: 'Carl',
  street_address: '100 Cat St.',
  city: 'Denver',
  state: 'CO',
  zipcode: '80207',
  description: 'no dogz allowed',
  status: 'Pending',
)
application_pet1 = ApplicationPet.create!(application_id: application1.id, pet_id: pet1.id)
application_pet2 = ApplicationPet.create!(application_id: application2.id, pet_id: pet2.id)
application_pet3 = ApplicationPet.create!(application_id: application3.id, pet_id: pet3.id)
