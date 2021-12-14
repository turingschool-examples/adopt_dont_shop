# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Shelter.destroy_all
PetApplication.destroy_all

application_1 = Application.create!(name: "Robin Dittrich", address: "111 Get Stoked Ave", city: "Bellingham", state: "WA", zip:"98225", description:"Mid sized home with two other dogs that need another friend", status: "pending")
shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
pet_2 = shelter_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
pet_application_1 = application_1.pet_applications.create!(pet_id: pet_1.id)
pet_application_1 = application_1.pet_applications.create!(pet_id: pet_2.id)
