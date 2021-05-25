# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Shelter.destroy_all
# Pet.destroy_all
# Application.destroy_all
# ApplicationPet.destroy_all

# shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
# shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
# shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

# pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Siamese Cat', name: 'Pear')
# pet2 = shelter1.pets.create!(adoptable: true, age: 1, breed: 'Blue Russian Cat', name: 'Oleg')
# pet3 = shelter1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Short Hair Cat', name: 'Ralph')
# pet4 = shelter2.pets.create!(adoptable: true, age: 3, breed: 'Racoon', name: 'Bob')
# pet5 = shelter2.pets.create!(adoptable: true, age: 4, breed: 'Racoon', name: 'Frank')
# pet6 = shelter2.pets.create!(adoptable: true, age: 5, breed: 'Racoon', name: 'Joe')
# pet7 = shelter3.pets.create!(adoptable: true, age: 6, breed: 'Pitbull', name: 'Cuddles')
# pet8 = shelter3.pets.create!(adoptable: true, age: 7, breed: 'Miniature Daschund', name: 'Sparky')
# pet9 = shelter3.pets.create!(adoptable: true, age: 8, breed: 'Greyhound', name: 'Grey')

# application1 = Application.create!(name: "Suzie Q", street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, statement: "TEST", status: 'Pending')
# application2 = Application.create!(name: "Jane Doe", street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, statement: "TEST", status: 'Pending')
# application3 = Application.create!(name: "Barak Obama", street_address: '1600 Pennsylvania Ave', city: 'Washington', state: 'DC', zip_code: 20500, statement: "TEST", status: 'Pending')

# application_pet1 = ApplicationPet.create!(application: application1, pet: pet1)
# application_pet2 = ApplicationPet.create!(application: application2, pet: pet3)
# application_pet3 = ApplicationPet.create!(application: application3, pet: pet2)