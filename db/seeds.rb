Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

vet_office_1 = VeterinaryOffice.create(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
vet_office_2 = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true,
                                       max_patient_capacity: 50)
vet_office_3 = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)
vet_office_1.veterinarians.create(name: 'Morgan', on_call: true, review_rating: 10)
vet_office_1.veterinarians.create(name: 'Heather', on_call: true, review_rating: 9)
vet_office_3.veterinarians.create(name: 'John', on_call: true, review_rating: 9)
