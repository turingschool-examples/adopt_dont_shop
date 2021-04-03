# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

fake = Faker

status = ['approved', 'incomplete']

#shelters
# 4.times do |i|
#   shelter = Shelter.create!(
#     foster_program: Faker::Boolean.boolean,
#     name: Faker::Company.name,
#     city: Faker::Address.city,
#     rank: Faker::Number.between(0,5)
#   )
# end
# #pets
# 10.times do |i|
#   Shelter.createpet = Pet.create!(
#     adoptable: Faker::Boolean.boolean,
#     age: Faker::Number.between(18,100),
#     breed: Faker::Creature::Dog.breed,
#     name: Faker::Creature::Dog.name
#   )
# end
#
# #applications
# 5.times do |i|
#   application = Application.create!(
#     name: Faker::Name.name,
#     street_address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     state: Faker::Address.state,
#     zip_code: Faker::Address.zip_code,
#     description: Faker::Company.bs,
#     status: fake.sample
#   )
# end

#application_pets


#veterinarians

#veterinary_offices
