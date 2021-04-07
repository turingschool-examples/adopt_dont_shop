VeterinaryOffice.destroy_all
Shelter.destroy_all
Application.destroy_all
User.destroy_all
ApplicationsPet.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
vet_office_1 = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create!(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 50)
vet_office_3 = VeterinaryOffice.create!(name: 'We Will Save Them', boarding_services: true, max_patient_capacity: 100)
user_1 = User.create!(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.', city: 'Cleveland', state: 'OH', zipcode: 18907)
user_2 = User.create!(full_name: 'Yo Lo', street_address: '95837 Tomahawk Dr.', city: 'Cincinatti', state: 'OH', zipcode: 44567)
user_3 = User.create!(full_name: 'Sam Smith', street_address: '34573 Board Rd.', city: 'Austin', state: 'TX', zipcode: 67875 )
application_1 = user_1.applications.create!(status: 'In Progress', description: 'Its floofy and I love it', user_id: user_1.id)
application_2 = user_2.applications.create!(status: 'In Progress', description: 'Its floofy and I love it', user_id: user_2.id)
application_3 = user_3.applications.create!(status: 'In Progress', description: 'Its floofy and I love it', user_id: user_3.id)


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

ApplicationsPet.create(pet_id: pet_1.id, application_id: application_1.id )
ApplicationsPet.create(pet_id: pet_2.id, application_id: application_1.id )
ApplicationsPet.create(pet_id: pet_2.id, application_id: application_2.id )
ApplicationsPet.create(pet_id: pet_3.id, application_id: application_3.id )
