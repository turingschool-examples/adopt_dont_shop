# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
Shelter.destroy_all
Pet.destroy_all

app1 = Application.create(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "In Progress" )
app2 = Application.create(fname: 'Jane', lname: 'Smithsonion', street_address: '34521 Avening Blvd.', city: 'Tdown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "Pending" )

shelter1 = Shelter.create(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

pet1 = shelter1.pets.create(adoptable: true, age: 5, breed: 'dog', name: 'Roofus')
pet2 = shelter1.pets.create(adoptable: true, age: 12, breed: 'cat', name: 'Nacho')
pet3 = shelter1.pets.create(adoptable: false, age: 8, breed: 'bird', name: 'Big')

shelter2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

pet4 = shelter2.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
pet5 = shelter2.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')

PetApplication.create(pet_id: pet2.id, application_id: app2.id)