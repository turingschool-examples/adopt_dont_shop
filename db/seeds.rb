# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Shelters
shelter_1 = Shelter.create!(foster_program: true, name: 'Save the Little Ones', city: 'Denver', rank: 13)
shelter_2 = Shelter.create!(foster_program: false, name: 'Dumb Friends League', city: 'Aurora', rank: 1)
shelter_3 = Shelter.create!(foster_program: true, name: 'Animal Resue', city: 'Wheatridge', rank: 72)
shelter_4 = Shelter.create!(foster_program: false, name: 'Pets for People', city: 'Stapleton', rank: 10)
shelter_5 = Shelter.create!(foster_program: true, name: 'Little Animal Rescue', city: 'Westminster', rank: 35)

#Pets
pet_1 = shelter_1.pets.create!(adoptable: true, age: 6, breed: 'Labrador Retriever', name: 'Lady', shelter_id: shelter_1.id)
pet_2 = shelter_1.pets.create!(adoptable: false, age: 2, breed: 'Bulldog', name: 'Frenchie', shelter_id: shelter_1.id)

pet_3 = shelter_2.pets.create!(adoptable: true, age: 6, breed: 'German Shepard', name: 'Sheep', shelter_id: shelter_2.id)
pet_4 = shelter_2.pets.create!(adoptable: false, age: 6, breed: 'Airedale Terrier', name: 'Daisy', shelter_id: shelter_2.id)

pet_5 = shelter_3.pets.create!(adoptable: true, age: 6, breed: 'Poodle', name: 'Lion', shelter_id: shelter_3.id)
pet_6 = shelter_3.pets.create!(adoptable: false, age: 6, breed: 'Afghan Hound', name: 'Buddy', shelter_id: shelter_3.id)

pet_7 = shelter_4.pets.create!(adoptable: true, age: 6, breed: 'Pitbul', name: 'Bailey', shelter_id: shelter_4.id)
pet_8 = shelter_4.pets.create!(adoptable: false, age: 6, breed: 'American Pitbul Terrier', name: 'Spicy', shelter_id: shelter_4.id)

pet_9 = shelter_5.pets.create!(adoptable: true, age: 6, breed: 'Siberian Husky', name: 'Fluffy', shelter_id: shelter_5.id)
pet_10 = shelter_5.pets.create!(adoptable: false, age: 6, breed: 'Great Dane', name: 'Tiny', shelter_id: shelter_5.id)

#Veterinarian Offices
vet_office_1 = VeterinaryOffice.create!(boarding_services: true, max_patient_capacity: 2, name: 'Little Critters Vet')
vet_office_2 = VeterinaryOffice.create!(boarding_services: false, max_patient_capacity: 4, name: 'Vets and Pets Veterinary Clinic')
vet_office_3 = VeterinaryOffice.create!(boarding_services: true, max_patient_capacity: 60, name: 'Colorado Veterinary Clinic')

#Veterinarians
vet_1 = vet_office_1.veterinarians.create!(on_call: true, review_rating: 3, name: 'Ms. Johnson', veterinary_office_id: vet_office_1.id)
vet_2 = vet_office_1.veterinarians.create!(on_call: false, review_rating: 5, name: 'Ms. Eckels', veterinary_office_id: vet_office_1.id)

vet_3 = vet_office_2.veterinarians.create!(on_call: true, review_rating: 1, name: 'Mr. Anderson', veterinary_office_id: vet_office_2.id)
vet_4 = vet_office_2.veterinarians.create!(on_call: false, review_rating: 3, name: 'Mr. Phillp', veterinary_office_id: vet_office_2.id)

vet_5 = vet_office_3.veterinarians.create!(on_call: true, review_rating: 4, name: 'Mr. Parker', veterinary_office_id: vet_office_3.id)
vet_6 = vet_office_3.veterinarians.create!(on_call: false, review_rating: 2, name: 'Ms. Willis', veterinary_office_id: vet_office_3.id)

#Applicants
applicant_1 = Applicant.create!(name: 'Mary Smith', street_address: '123 W Lost Ln', city: 'Denver', state: 'CO', zip_code: '80239', description: 'Words that describe')
applicant_1 = Applicant.create!(name: 'Larry Peters', street_address: '456 E Where Dr', city: 'Aurora', state: 'CO', zip_code: '80012', description: 'The reasons I want a pet')
applicant_1 = Applicant.create!(name: 'Harry Boyd', street_address: '789 S Who Pl', city: 'Westminster', state: 'CO', zip_code: '80020', description: 'Fuzzy creatures are fun')