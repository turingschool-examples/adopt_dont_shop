# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Pet.destroy_all
Application.destroy_all
PetApplication.destroy_all
Shelter.destroy_all

vet_office_1 = VeterinaryOffice.create(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
vet_office_2 = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
vet_office_3 = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)
vet1 = vet_office_1.veterinarians.create(name: 'Morgan', on_call: true, review_rating: 10)
vet2 = vet_office_1.veterinarians.create(name: 'Heather', on_call: true, review_rating: 9)
vet3 = vet_office_3.veterinarians.create(name: 'John', on_call: true, review_rating: 9)
vet4 = vet_office_2.veterinarians.create(name: 'Edd', on_call: false, review_rating: 10)


shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
shelter_3 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 7)

pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
pet_4 = shelter_2.pets.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna')
pet_5 = shelter_2.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
pet_6 = shelter_3.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
pet_7 = shelter_3.pets.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven')

application1 = Application.create!(
    name: 'Joe Exotic',
    street_address: '3150 Horton Rd',
    city: 'Fort Worth',
    state: 'TX',
    zip_code: 76119,
    description: 'I just really love animals',
    status: 'Rejected'
)
application2 = Application.create!(
    name: 'Carol Baskins',
    street_address: '12802 Easy St',
    city: 'Tampa',
    state: 'FL',
    zip_code: 33625,
    description: 'I just really love animals more than that other guy',
    status: 'Rejected'
)
application3 = Application.create!(
    name: 'Steve Irwin',
    street_address: '1111 Heaven St',
    city: 'Sydney',
    state: 'NSW-AU',
    zip_code: 20000,
    description: 'Big fan of animals.',
    status: 'Approved'
)
application4 = Application.create!(
    name: 'Mister Rogers',
    street_address: '1 MakeBelieve court',
    city: 'Toronto',
    state: 'Ontario',
    zip_code: 66777,
    description: 'I just wanna shine a little light in their little lives.',
    status: 'Approved'
)

pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
pet_application_2 = PetApplication.create!(pet: pet_2, application: application2)
pet_application_3 = PetApplication.create!(pet: pet_3, application: application2)
pet_application_4 = PetApplication.create!(pet: pet_6, application: application3)
pet_application_5 = PetApplication.create!(pet: pet_7, application: application3)
pet_application_6 = PetApplication.create!(pet: pet_1, application: application3)
pet_application_7 = PetApplication.create!(pet: pet_4, application: application4)
pet_application_8 = PetApplication.create!(pet: pet_2, application: application4)
pet_application_9 = PetApplication.create!(pet: pet_4, application: application4)
pet_application_10 = PetApplication.create!(pet: pet_5, application: application3)
