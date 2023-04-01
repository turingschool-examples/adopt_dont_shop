# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter_1.id)
vet_office = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
vet_1 = Veterinarian.create!(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office.id)
vet_2 = Veterinarian.create!(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)
application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')
PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)