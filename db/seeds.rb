VeterinaryOffice.destroy_all
Shelter.destroy_all
Shelter.reset_pk_sequence
Veterinarian.reset_pk_sequence
Pet.reset_pk_sequence
VeterinaryOffice.reset_pk_sequence


shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
vet_office_1 = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create!(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 50)
vet_office_3 = VeterinaryOffice.create!(name: 'We Will Save Them', boarding_services: true, max_patient_capacity: 100)


shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

shelter_2.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
shelter_2.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

shelter_3.pets.create!(name: 'Frank', breed: 'dachshund', age: 6, adoptable: true)
shelter_3.pets.create!(name: 'Buddy', breed: 'doberman', age: 2, adoptable: false)

vet_office_1.veterinarians.create!(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office_1.id)
vet_office_1.veterinarians.create!(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office_1.id)

vet_office_2.veterinarians.create!(name: 'Bucky', review_rating: 5, on_call: true, veterinary_office_id: vet_office_2.id)
vet_office_2.veterinarians.create!(name: 'Sarah', review_rating: 7, on_call: false, veterinary_office_id: vet_office_2.id)

vet_office_3.veterinarians.create!(name: 'Joe', review_rating: 3, on_call: true, veterinary_office_id: vet_office_3.id)
vet_office_3.veterinarians.create!(name: 'Rebecca', review_rating: 9, on_call: true, veterinary_office_id: vet_office_3.id)
