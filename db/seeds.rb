# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Application.destroy_all
PetApplication.destroy_all



@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
@pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
@pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
@pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
@pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_3.id)
@shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
@vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
@vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office.id)
@vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office.id)
@vet_office_2 = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
@vet_office_2.veterinarians.create(name: 'Morgan', on_call: true, review_rating: 10)
@vet_office_2.veterinarians.create(name: 'Heather', on_call: true, review_rating: 9)
@application_1 = Application.create!(applicant_name: 'Bob Ross', address: '8753 Main St Longmont CO 80765', description: 'I make a lot of money', status: 'rejected')
@application_2 = Application.create!(applicant_name: 'Meredith Grey', address: '3463 Collin St Denver CO 80035', description: 'I love animals', status: 'accepted')
@application_3 = Application.create!(applicant_name: 'Post Malone', address: '6543 Peoria St Denver CO 80056', description: 'I am a foster pet parent', status: 'pending')
@application_4 = Application.create!(applicant_name: 'Doja Cat', address: '9742 Billings St Aurora CO 80245', description: 'I need an emotional support animal', status: 'in progress')

PetApplication.create(pet_id: @pet_1.id, application_id: @application_1.id)
PetApplication.create(pet_id: @pet_2.id, application_id: @application_1.id)

