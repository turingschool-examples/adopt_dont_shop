# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

app = Application.create!(name: 'Hugh Man',
  city: 'Denver',
  street_address: '123 lion st',
  state: 'CO',
  zip: 12345 )
shelter = Shelter.create!(foster_program: true,
 name: 'Bundle park',
 city: 'Denver',
 rank: 3
)
dog1 = shelter.pets.create!(adoptable: true,
   age: 2,
   breed: 'Bull',
   name: 'Bob'
 )
dog2 = shelter.pets.create!(adoptable: true,
  age: 2,
  breed: 'Golden',
  name: 'Billy'
)
