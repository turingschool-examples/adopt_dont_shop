# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
Petition.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
PetPetition.destroy_all

denver = Shelter.create!(name: 'Denver Pet Shelter', city: 'Denver', rank: 1, foster_program: true)
greely = Shelter.create!(name: 'Greely Dumb Friends League', city: 'Greelyr', rank: 2, foster_program: true)
eagle = Shelter.create!(name: 'Eagle Pet Sanctuary', city: 'Eagle', rank: 3, foster_program: true)

fluffy = denver.pets.create!(name: 'Fluffy', breed: 'Siamese Cat', age: 12, adoptable: true)
scruffy = denver.pets.create!(name: 'Scruffy', breed: 'Bulldog', age: 1, adoptable: true)
tig = denver.pets.create!(name: 'Tig', breed: 'Calico Cat', age: 2, adoptable: true)

deborah = greely.pets.create!(name: 'Deborah', breed: 'Goldfish', age: 6, adoptable: true)
terrence = greely.pets.create!(name: 'Terrence', breed: 'Parrot', age: 7, adoptable: true)
paul = greely.pets.create!(name: 'Paul', breed: 'Kimodo Dragon', age: 8, adoptable: true)

daisy = eagle.pets.create!(name: 'Daisy', breed: 'Maine Coon Cat', age: 2, adoptable: true)
moon = eagle.pets.create!(name: 'Moon', breed: 'Dacshund', age: 3, adoptable: true)
chalky = eagle.pets.create!(name: 'Chalky', breed: 'Pekingese', age: 4, adoptable: true)
chomper = eagle.pets.create!(name: 'Chomper', breed: 'Pig', age: 5, adoptable: true)

hospital = VeterinaryOffice.create!(name: 'Denver Pet Hospital', max_patient_capacity: 12, boarding_services: false)
vet = VeterinaryOffice.create!(name: 'Bettes Vets', max_patient_capacity: 2, boarding_services: true)
doctor = VeterinaryOffice.create!(name: 'Doctor Paws', max_patient_capacity: 7, boarding_services: true)

ramesh = hospital.veterinarians.create!(name: 'Ramesh Ranganathan', review_rating: 10, on_call: false)
nish = hospital.veterinarians.create!(name: 'Nish Kumar', review_rating: 1, on_call: true)
aislin = hospital.veterinarians.create!(name: 'Aislin Bea', review_rating: 6, on_call: true)

greg = vet.veterinarians.create!(name: 'Greg Davies', review_rating: 4, on_call: true)
sarah = vet.veterinarians.create!(name: 'Sarah Pascoe', review_rating: 8, on_call: true)

victoria = doctor.veterinarians.create!(name: 'Victoria Coren Mitchell', review_rating: 10, on_call: true)
david = doctor.veterinarians.create!(name: 'David Mitchell', review_rating: 7, on_call: false)
lolly = doctor.veterinarians.create!(name: 'Lolly Adefope', review_rating: 9, on_call: true)
mel = doctor.veterinarians.create!(name: 'Mel Gedroic', review_rating: 2, on_call: true)

ted = Petition.create!(name: 'Ted Leo',
                       street_address: '123 Pharmacist Ln',
                       city: 'Denver',
                       state: 'Co',
                       zipcode: 12_345,
                       goodhome: 'Lurv Fluffers',
                       status: 'Pending')
thao = Petition.create!(name: 'Thao Nguyen',
                        street_address: '456 Getdown St',
                        city: 'Los Angeles',
                        state: 'CA',
                        zipcode: 23_456,
                        goodhome: 'Need Dragons',
                        status: 'Pending')

application_1 = PetPetition.create!(petition: ted, pet: chomper)
application_2 = PetPetition.create!(petition: ted, pet: paul)
application_3 = PetPetition.create!(petition: thao, pet: paul)
application_4 = PetPetition.create!(petition: thao, pet: daisy)
