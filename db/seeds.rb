# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
ApplicationPet.destroy_all

shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
scooby = shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
piglet = shelter.pets.create!(name: 'Piglet',  age: 1, breed: 'Micro Pig', adoptable: true, shelter_id: shelter.id)
garfield = shelter.pets.create!(name: 'Garfield',  age: 4, breed: 'Orange Tabby Persian', adoptable: true , shelter_id: shelter.id)

application_1 = Application.create!(name: 'Shaggy', address: '2541 Spooky Lane', city: 'Coolsville', state: 'Ohio', zipcode: '12345', rationale: 'I want a best friend to eat Scooby snacks with', status: 'In-progress')
application_2 = Application.create!(name: 'Michael Vick', address: '38747 Brooklyn Lane', city: 'Brooklyn', state: 'New York', zipcode: '11200', rationale: 'I need fighters for my underground dog fight club', status: 'In-progress')
application_3 = Application.create!(name: 'Michael Scott', address: '4543 Albuquerque Lane', city: 'Albuquerque', state: 'New Mexico', zipcode: '13579', rationale: 'I am sad and need company', status: 'In-progress')

application_pet1 = ApplicationPet.create!(pet_id: scooby.id, application_id: application_1.id)
application_pet2 = ApplicationPet.create!(pet_id: piglet.id, application_id: application_2.id)
application_pet3 = ApplicationPet.create!(pet_id: garfield.id, application_id: application_3.id)
