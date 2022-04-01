 Shelter.destroy_all
 Pet.destroy_all
 VeterinaryOffice.destroy_all
 Veterinarian.destroy_all
# Application.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
@pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

#@vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
#@vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)
#@vet_1 = @vet_office.veterinarians.create(name: 'Taylor', review_rating: 10, on_call: true)
#@vet_2 = @vet_office.veterinarians.create(name: 'Tanya', review_rating: 9, on_call: true)
#@vet_3 = @vet_office.veterinarians.create(name: 'Jim', review_rating: 8, on_call: true)
#@not_on_call_vet = @vet_office.veterinarians.create(name: 'Sam', review_rating: 10, on_call: false)
