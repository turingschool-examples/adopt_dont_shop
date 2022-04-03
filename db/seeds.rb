# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
shelter2 = Shelter.create!(foster_program: false, name: 'Portland Shelter', city: 'Phoenix', rank: 20)
spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
