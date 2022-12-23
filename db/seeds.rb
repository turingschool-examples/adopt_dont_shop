# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

3.times do 
  Shelter.create(
    name: Faker::App.name,
    foster_program: Faker::Boolean::boolean(true_ratio: 0.5),
    city: Faker::Address.city,
    rank: rand(1..100)
  )
end

50.times do
  Pet.create(
    name: Faker::FunnyName.name,
    adoptable: Faker::Boolean::boolean(true_ratio: 0.66),
    age: rand(1..1000),
    breed: Faker::Creature::Cat.breed,
    shelter_id: Shelter.all.sample.id
  )
end

5.times do
  VeterinaryOffice.create(
    boarding_services: Faker::Boolean::boolean(true_ratio: 0.66),
    max_patient_capacity: rand(5..30),
    name: Faker::Company.name
  )
end

30.times do
  Veterinarian.create(
    on_call: Faker::Boolean::boolean(true_ratio: 0.5),
    review_rating: rand(1..5),
    name: Faker::Name.name,
    veterinary_office_id: VeterinaryOffice.all.sample.id
  )
end

10.times do
  Application.create(
    name: Faker::FunnyName.two_word_name,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip_code,
    description: Faker::Lorem.sentence
  )
end
