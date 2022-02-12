PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all

vet_office_1 = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create!(name: 'Good Heart', boarding_services: false, max_patient_capacity: 14)
vet_1 = Veterinarian.create!(name: 'Star', review_rating: 9, on_call: false, veterinary_office_id: vet_office_1.id)
vet_2 = Veterinarian.create!(name: 'McCartney', review_rating: 8, on_call: true, veterinary_office_id: vet_office_1.id)
vet_3 = Veterinarian.create!(name: 'Harrison', review_rating: 10, on_call: false, veterinary_office_id: vet_office_2.id)
vet_4 = Veterinarian.create!(name: 'Lennon', review_rating: 9, on_call: true, veterinary_office_id: vet_office_2.id)

shelter_1 = Shelter.create(name: 'Dumb Friends League', city: 'Denver CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'MaxFund', city: 'Denver CO', foster_program: false, rank: 9)
pet_1 = Pet.create!(adoptable: true, age: 2, breed: 'domestic short hair', name: 'Mundungous', shelter_id: shelter_1.id)
pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Captain Pants', shelter_id: shelter_1.id)
pet_3 = Pet.create!(adoptable: true, age: 3, breed: 'scottish fold', name: 'Greg', shelter_id: shelter_1.id)
pet_4 = Pet.create!(adoptable: true, age: 4, breed: 'domestic long hair', name: 'Hogan', shelter_id: shelter_2.id)
pet_5 = Pet.create!(adoptable: true, age: 4, breed: 'domestic long hair', name: 'Bloopie', shelter_id: shelter_2.id)
pet_6 = Pet.create!(adoptable: true, age: 1, breed: 'mainecoon', name: 'Sullivan', shelter_id: shelter_2.id)

application_1 = Application.create!(name: "Holden Caulfield", street_address: "123 Main St", city: "Denver", state: "CO", zipcode: 80216, description: "I wouldn't be a good pet owner", status: "Pending")
application_2 = Application.create!(name: "Hermione Granger", street_address: "987 Broadway", city: "Denver", state: "CO", zipcode: 80203, description: "I love animals.", status: "Pending")
application_3 = Application.create!(name: "Dr. Dolittle", street_address: "456 Colorado", city: "Denver", state: "CO", zipcode: 80211, description: "I am a great caretaker of many animals and have a great home for more!", status: "Pending")

PetApplication.create!(pet: pet_1, application: application_1)
PetApplication.create!(pet: pet_2, application: application_2)
PetApplication.create!(pet: pet_3, application: application_3)
PetApplication.create!(pet: pet_4, application: application_1)
PetApplication.create!(pet: pet_5, application: application_2)
PetApplication.create!(pet: pet_6, application: application_3)
