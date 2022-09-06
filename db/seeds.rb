# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

app1 = Application.create(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "In Progress" )
app2 = Application.create(fname: 'Jane', lname: 'Smithsonion', street_address: '34521 Avening Blvd.', city: 'Tdown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "Pending" )
app3 = Application.create!(fname: 'ohn', lname: 'mith', street_address: '234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsae', status: "Pending" )
app4 = Application.create!(fname: 'hn', lname: 'ith', street_address: '34 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsa', status: "Pending" )

shelter1 = Shelter.create(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

pet1 = shelter1.pets.create(adoptable: true, age: 5, breed: 'dog', name: 'Roofus')
pet2 = shelter1.pets.create(adoptable: true, age: 12, breed: 'cat', name: 'Nacho')
pet3 = shelter1.pets.create(adoptable: false, age: 8, breed: 'bird', name: 'Big')

shelter2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

pet4 = shelter2.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
pet5 = shelter2.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')

shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet6 = shelter3.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Baldy')
pet7 = shelter3.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Globe')


PetApplication.create(pet_id: pet2.id, application_id: app2.id, pet_status: "Adoption Approved")
app1.pets << pet1
app1.pets << pet2
app3.pets << pet1
app3.pets << pet4
app4.pets << pet5
app4.pets << pet1





