# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
application = Application.create!(name: 'Andrew',
  street_address: '112 Greenbrook',
  city: 'Denver',
  state: 'CO',
  zipcode: '80207',
  description: 'Happy, friendly, cool',
  status: 'In Progress',
)
