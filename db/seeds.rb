# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Shelter.destroy_all
Pet.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

@application_1 = Application.create!(name: 'Bob', street_address: '1234 Southeast St',
  city: 'San Francisco', state: 'CA', zip_code: 12345,
  description: 'Wants a dog', names_of_pets: 'Fluffy', application_status: 'Pending')

@application_2 = Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
  city: 'San Francisco', state: 'CA', zip_code: 54321,
  description: 'Would like a siamese cat', names_of_pets: 'Coz', application_status: 'In Progress')

@application_3 = Application.create!(name: 'Fred', street_address: '376 Monroe St',
  city: 'Los Angeles', state: 'CA', zip_code: 67890,
  description: 'Interested in sibling pets', names_of_pets: 'Jack, Jill', application_status: 'Accepted')

@application_4 = Application.create!(name: 'Jane', street_address: '74026 Deep South St',
  city: 'San Diego', state: 'CA', zip_code: 92056,
  description: 'Doesnt like animals', names_of_pets: 'Mittens', application_status: 'Rejected')

@shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter_1)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter: @shelter_2)
@pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter: @shelter_3)

@vet_office_1 = VeterinaryOffice.create!(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
@vet_office_2 = VeterinaryOffice.create!(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
@vet_office_3 = VeterinaryOffice.create!(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)

@vet_1 = Veterinarian.create!(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office: @vet_office_1)
@vet_2 = Veterinarian.create!(name: 'Jim', review_rating: 8, on_call: true, veterinary_office: @vet_office_2)
@vet_3 = Veterinarian.create!(name: 'Heather', review_rating: 9, on_call: true, veterinary_office: @vet_office_3)
