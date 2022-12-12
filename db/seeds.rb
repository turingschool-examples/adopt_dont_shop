# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" )
# shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
# application_2 = Application.create!(name: 'Bob', street_address: "789 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "in progress" )
# shelter_2 = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)

# pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_2.id)
# pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
# pet_3 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Kona', shelter_id: shelter.id)
 
2.times{FactoryBot.create(:application)}
3.times{FactoryBot.create(:shelter)}
10.times{FactoryBot.create(:pet)}