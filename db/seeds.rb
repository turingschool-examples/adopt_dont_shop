# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Application.destroy_all
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all

@vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
@vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)
@not_on_call_vet = Veterinarian.create(
  name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: @vet_office_1.id
)
@vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office_1.id)
@vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_1.id)
@vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: @vet_office_2.id)

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
@pet_4 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

@application = Application.create(
  name: 'Sherman',
  address: '123 Main St', city: 'Longmont', state: 'CO', zipcode: '80501',
  description: 'Loves animals',
  status: 'Accepted'
)

PetApplication.create!(pet_id: @pet_1.id, application_id: @application.id)
PetApplication.create!(pet_id: @pet_2.id, application_id: @application.id)
