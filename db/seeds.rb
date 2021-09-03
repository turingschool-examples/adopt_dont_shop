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
PetApplication.destroy_all

shelter_1 = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter_1.id)
pet_2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Mose', shelter_id: shelter_1.id)
application_1 = Application.create(name: 'Jamie', street: '123 S Pearl St', state: "Colorado", city: "Denver", zip_code: "80212", description: "Really loves dogs", status: "Pending")
PetApplication.create(pet: pet_1, application: application_1)
