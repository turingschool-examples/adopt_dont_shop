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


pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

pet_3 = shelter_2.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_2.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

shelter_3.pets.create!(name: 'Frank', breed: 'dachshund', age: 6, adoptable: true)
shelter_3.pets.create!(name: 'Buddy', breed: 'doberman', age: 2, adoptable: false)

vet_office_1.veterinarians.create!(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office_1.id)
vet_office_1.veterinarians.create!(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office_1.id)

vet_office_2.veterinarians.create!(name: 'Bucky', review_rating: 5, on_call: true, veterinary_office_id: vet_office_2.id)
vet_office_2.veterinarians.create!(name: 'Sarah', review_rating: 7, on_call: false, veterinary_office_id: vet_office_2.id)

vet_office_3.veterinarians.create!(name: 'Joe', review_rating: 3, on_call: true, veterinary_office_id: vet_office_3.id)
vet_office_3.veterinarians.create!(name: 'Rebecca', review_rating: 9, on_call: true, veterinary_office_id: vet_office_3.id)

pet_1.adopting_applications.create(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.',
                                   city: 'Cleveland', state: 'OH', zipcode: 18907,
                                   description: 'I like this dog. It is very fluffy. Let me have it.',
                                   in_progress: true, accepted: false, declined: false)
pet_2.adopting_applications.create(full_name: 'Sam Smith', street_address: '95837 Tomahawk Dr.',
                                   city: 'Cincinatti', state: 'OH', zipcode: 44567 ,
                                   description: 'I have been a big fan of birds since I was a child. I would like to adopt this little guy so I can have a friend.',
                                   in_progress: false, accepted: true, declined: false)
pet_3.adopting_applications.create(full_name: 'Yo Lo', street_address: '34573 Board Rd.',
                                   city: 'Austin', state: 'TX', zipcode: 67875,
                                   description: 'I have 25 cats. Another one wouldnt hurt',
                                   in_progress: true, accepted: false, declined: false)
pet_4.adopting_applications.create(full_name: 'Kristy Teal', street_address: '47674 Bolas St.',
                                   city: 'San Fransisco', state: 'CA', zipcode: 18907,
                                   description: 'I am a lover of animals and I have been ever since I was little. I would love to give this bird a home.',
                                   in_progress: true, accepted: false, declined: false)
