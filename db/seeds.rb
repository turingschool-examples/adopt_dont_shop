# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 8)
shelter_3 = Shelter.create!(name: 'Vail shelter', city: 'Vail, CO', foster_program: false, rank: 7)
pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)
pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter_2.id)
pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter_1.id)
applicant = Application.create!(name: 'Dawson', 
street_address: '1234 example ave.', 
city: 'Denver', 
state: 'CO',
zip_code: 12345, 
reason_for_adoption: "I love dogs",
status: "In Progress"
)