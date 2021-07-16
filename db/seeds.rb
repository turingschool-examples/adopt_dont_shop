# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Pet.destroy_all
Shelter.destroy_all
# Application.destroy_all

# Shelters
shelter_1 = Shelter.create!(
  name: 'Aurora Shelter',
  address: '123 Main St.',
  city: 'Aurora',
  state: 'CO',
  zipcode: '80010',
  foster_program: false,
  rank: 9)
shelter_2 = Shelter.create!(
  name: 'Boulder Shelter',
  address: '45 Broadway Ave',
  city: 'Boulder',
  state: 'CO',
  zipcode: '80302',
  foster_program: false,
  rank: 9)

# Pets
shelter_1.pets.create!(
  name: 'Mr. Pirate',
  breed: 'Tuxedo Shorthair',
  age: 5,
  adoptable: true)
shelter_1.pets.create!(
  name: 'Clawdia',
  breed: 'Exotic Shorthair',
  age: 3,
  adoptable: true)
shelter_1.pets.create!(
  name: 'Ann',
  breed: 'Ragdoll',
  age: 3,
  adoptable: false)

shelter_2.pets.create!(
  name: 'Macaroni',
  breed: 'Scottish Fold',
  age: 2,
  adoptable: true)
shelter_2.pets.create!(
  name: 'Dumpling',
  breed: 'Russian Blue',
  age: 6,
  adoptable: true)

# # Applications
# application_1 = Application.create!(
#   applicant_lastname: 'Smith',
#   applicant_firstname: 'John',
#   applicant_address: '1200 3rd St.',
#   applicant_city: 'Golden',
#   applicant_state: 'CO',
#   applicant_zipcode: '80401',
#   applicant_description: 'I am a good guy',
#   status: 'In Progress')
# application_2 = Application.create!(
#   applicant_lastname: 'Doe',
#   applicant_firstname: 'Jane',
#   applicant_address: '500 Poplar Ave.',
#   applicant_city: 'Wheat Ridge',
#   applicant_state: 'CO',
#   applicant_zipcode: '80401',
#   applicant_description: 'I want a kitty!',
#   status: 'In Progress')
