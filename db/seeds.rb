# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')
      pet_2 = shelter.pets.create!(adoptable: true, age: 7, breed: 'tiger', name: 'Fluffy 2')
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake St', city: 'Denver', state: 'CO', zip_code: '90210')