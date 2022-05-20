# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all
ApplicationPet.destroy_all

dumb_friends = Shelter.create!(name: 'Denver Dumb Friends League', city: 'Denver', rank: 4, foster_program: true)
boulder_county = Shelter.create!(name: 'Boulder County Shelter', city: 'Boulder', rank: 7, foster_program: true)
humane_society = Shelter.create!(name: 'Humane Society', city: 'Denver', rank: 12, foster_program: false)
max_fund = Shelter.create!(name: 'MaxFund Shelter', city: 'Oakland', rank: 2, foster_program: true)

rajah = dumb_friends.pets.create!(name: 'Rajah', breed: 'cat', age: 5, adoptable: false)
stacks = dumb_friends.pets.create!(name: 'Stacks', breed: 'german shepherd', age: 10, adoptable: true)

flaubert = boulder_county.pets.create!(name: 'Flaubert', breed: 'terrier', age: 2, adoptable: true)
pavel = boulder_county.pets.create!(name: 'Pavel', breed: 'cat', age: 4, adoptable: true)

milo = humane_society.pets.create!(name: 'Milo', breed: 'dashchund', age: 10, adoptable: true)
mali = humane_society.pets.create!(name: 'Mali', breed: 'cat', age: 3, adoptable: true)
kevin = humane_society.pets.create!(name: 'Kevin', breed: 'lab', age: 14, adoptable: true)

spot = max_fund.pets.create!(name: 'Spot', breed: 'dalmatian', age: 4, adoptable: false)
princess= max_fund.pets.create!(name: 'Princess', breed: 'cat', age: 3, adoptable: true)
pumpkin= max_fund.pets.create!(name: 'Pumpkin', breed: 'cat', age: 5, adoptable: true)

application_1 = Application.create!(name: 'Antonio', street_address: '1234 Drury Lane', city: 'San Francisco', state: 'CA', zip_code: '94016', description: status:)
application_2 = Application.create!(name: 'Casey', street_address: '1564 Pearl Street', city: 'Boulder', state: 'C0', zip_code: '80037', description: status:)
application_3 = Application.create!(name: 'Deannah', street_address: '1424 Pennsylvania Ave', city: 'Denver', state: 'CO', zip_code: '80214', description: status:)

ApplicationPet.create!(application: application_1, pet: rajah)
ApplicationPet.create!(application: application_1, pet: pavel)
ApplicationPet.create!(application: application_1, pet: flaubert)
ApplicationPet.create!(application: application_1, pet: spot)
ApplicationPet.create!(application: application_2, pet: princess)
ApplicationPet.create!(application: application_2, pet: kevin)
ApplicationPet.create!(application: application_2, pet: milo)
ApplicationPet.create!(application: application_3, pet: mali)
ApplicationPet.create!(application: application_3, pet: stacks)
