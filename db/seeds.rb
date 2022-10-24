# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  application_1 = Application.create!(name: 'Pam Pulzone', street_address: '66225 Wallace Rd', city: 'Bend', state: 'OR', zip: 97702, description: 'Fenced yard, loving home', status: 'In Progress')
  application_2 = Application.create!(name: 'Dan Boston', street_address: '774 Boone Rd', city: 'Greenville', state: 'SC', zip: 56843, description: 'Experience with difficult dogs', status:  'In Progress')
  shelter_1= Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  shelter_2 = Shelter.create(name: 'HSCO', city: 'Bend, OR', foster_program: true, rank: 4)
  pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
  pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
  pet_3 = Pet.create(adoptable: false, age: 8, breed: 'mix', name: 'Kumquat', shelter_id: shelter_2.id)