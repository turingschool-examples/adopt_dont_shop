# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ApplicationPet.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

@shelter_1 = Shelter.create!(
  foster_program: true,
  name: "Healthy Paws",
  city: "Denver",
  rank: 3
)

@shelter_2 = Shelter.create!(
  foster_program: true,
  name: "Ruff Day",
  city: "Detroit",
  rank: 2
)

@shelter_3 = Shelter.create!(
  foster_program: true,
  name: "AAA Shelter",
  city: "Houston",
  rank: 1
)

@application_1 = Application.create!(
  name: "Bob",
  street_address: "123 Leaf Street",
  city: "Denver",
  state: "CO",
  zip_code: 80020,
  description: "Work from home",
  status: "In Progress"
)

@application_2 = Application.create!(
  name: "Tom",
  street_address: "508 Maple Street",
  city: "Denver",
  state: "CO",
  zip_code: 80020,
  description: "Love animals",
  status: "Pending"
)

@application_3 = Application.create!(
  name: "Sam",
  street_address: "8591 Pine Street",
  city: "Denver",
  state: "CO",
  zip_code: 80021,
  description: "Have a large yard for a furbaby",
  status: "Pending"
)

@application_4 = Application.create!(
  name: "Susan",
  street_address: "2210 Palm Street",
  city: "Denver",
  state: "CO",
  zip_code: 80240,
  description: "Looking for a running  buddy",
  status: "In Progress"
)

@pet_1 = Pet.create!(
  name: "Pepper",
  adoptable: true,
  age: 4,
  breed: "Pitbull",
  shelter_id: @shelter_1.id
)
  
@pet_2 = Pet.create!(
  name: "Daisy",
  adoptable: true,
  age: 14,
  breed: "Beagle",
  shelter_id: @shelter_1.id
)

@pet_3 = Pet.create!(
  name: "Pumba", 
  adoptable: true, 
  age: 14, 
  breed: "Corgi", 
  shelter_id: shelter_2.id
)

@pet_4 = Pet.create!( 
  name: "Timon", 
  adoptable: true, 
  age: 14, 
  breed: "Dacshund", 
  shelter_id: shelter_3.id
)

application_pet_1 = ApplicationPet.create!(
  application: application_1, 
  pet: pet_1
)

application_pet_2 = ApplicationPet.create!(
  application: application_2, 
  pet: pet_2
)

application_pet_3 = ApplicationPet.create!(
  application: application_3, 
  pet: pet_3
)

application_pet_4 = ApplicationPet.create!(
  application: application_4, 
  pet: pet_1
)
  