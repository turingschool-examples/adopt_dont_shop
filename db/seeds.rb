# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'Sandia Shelter', city: 'Albuquerque, NM', foster_program: true, rank: 7)
shelter_3 = Shelter.create(name: 'La Cueva Shelter', city: 'Denver, CO', foster_program: false, rank: 2)
shelter_4 = Shelter.create(name: 'Oakmont Shelter', city: 'New York, NY', foster_program: true, rank: 8)

application_1 = Application.create(name: "Michael Hicks", address: "858 S Emerson St", city: "Dever", state: "CO", zipcode: "80211")
application_2 = Application.create(name: "Suzanne Roth", address: "9406 Oakmont Rd", city: "Albuquerque", state: "NM", zipcode: "87111", description: "Best dog mom ever!", status: "Accepted")
application_3 = Application.create(name: "Ada Hicks", address: "4012 Tracy St NE", city: "Albuquerque", state: "NM", zipcode: "87111", description: "I'm actually a dog myself!", status: "Pending")


pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)
pet_3 = Pet.create(name: 'Karl', breed: 'Brittany', age: 2, adoptable: true, shelter_id: shelter_2.id)
pet_4 = Pet.create(name: 'Ned', breed: 'Berner', age: 1, adoptable: true, shelter_id: shelter_2.id)
pet_5 = Pet.create(name: 'Foster', breed: 'Aussie', age: 4, adoptable: true, shelter_id: shelter_3.id)
pet_6 = Pet.create(name: 'Billy', breed: 'Bloodhound', age: 2, adoptable: true, shelter_id: shelter_3.id)
pet_7 = Pet.create(name: 'Blanca', breed: 'Blue Heeler', age: 3, adoptable: true, shelter_id: shelter_4.id)
pet_8 = Pet.create(name: 'Steve', breed: 'Poodle', age: 1, adoptable: true, shelter_id: shelter_4.id)

PetApplication.create!(pet: pet_1, application: application_2)
PetApplication.create!(pet: pet_2, application: application_2)

PetApplication.create!(pet: pet_3, application: application_3)
PetApplication.create!(pet: pet_4, application: application_3)
