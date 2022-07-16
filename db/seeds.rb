# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApp.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
App.destroy_all

shelter_1 = Shelter.create!(name: "Dumb Friends League", city: "Denver", rank: 1, foster_program: true)
pet_1 = shelter_1.pets.create!(name: "Parker", breed: "Lab", age: 5, adoptable: false)
pet_2 = shelter_1.pets.create!(name: "Rugsby", breed: "Beagle", age: 6, adoptable: true)
pet_3 = shelter_1.pets.create!(name: "Keyba", breed: "Shepherd", age: 7, adoptable: true)

shelter_2 = Shelter.create!(name: "Foothills Animal Shelter", city: "Lakewood", rank: 2, foster_program: false)
pet_4 = shelter_2.pets.create!(name: "Bingly", breed: "Mix", age: 8, adoptable: true)
pet_5 = shelter_2.pets.create!(name: "Juju", breed: "Boston", age: 2, adoptable: false)
pet_6 = shelter_2.pets.create!(name: "Carl", breed: "Bulldog", age: 4, adoptable: false)

app_1 = App.create!(name: "Mark", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "I'm lonely", status: "in progress")
app_2 = App.create!(name: "Tom", address: "4567 Elm St", city: "Centennial", state: "CO", zip: "80209", description: "I'm bored", status: "in progress")
app_3 = App.create!(name: "Jeff", address: "1234 Dahlia Rd", city: "Tampa", state: "FL", zip: "90210", description: "I like turtles", status: "in progress")

petapp_1 = PetApp.create!(app_id: app_1.id, pet_id: pet_2.id)
petapp_2 = PetApp.create!(app_id: app_1.id, pet_id: pet_4.id)
petapp_3 = PetApp.create!(app_id: app_2.id, pet_id: pet_4.id)

vetoffice_1 = VeterinaryOffice.create!(name: "Park Hill Vet", max_patient_capacity: 15, boarding_services: true)
vet_1 = vetoffice_1.veterinarians.create!(name: "Bob", review_rating: 3, on_call: true)
vet_2 = vetoffice_1.veterinarians.create!(name: "Sam", review_rating: 5, on_call: true)
vet_3 = vetoffice_1.veterinarians.create!(name: "Joe", review_rating: 1, on_call: false)

vetoffice_2 = VeterinaryOffice.create!(name: "Dogtor's Office", max_patient_capacity: 10, boarding_services: false)
vet_4 = vetoffice_2.veterinarians.create!(name: "Fred", review_rating: 2, on_call: false)
vet_5 = vetoffice_2.veterinarians.create!(name: "Bill", review_rating: 4, on_call: true)
vet_6 = vetoffice_2.veterinarians.create!(name: "Doug", review_rating: 5, on_call: false)
