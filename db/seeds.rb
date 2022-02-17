# Shelter.destroy_all
# Pet.destroy_all
# VeterinaryOffice.destroy_all
# Veterinarian.destroy_all
# Application.destroy_all


@shelter_1 = Shelter.find_or_create_by!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.find_or_create_by!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.find_or_create_by!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@pet_1 = Pet.find_or_create_by!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
@pet_2 = Pet.find_or_create_by!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
@pet_3 = Pet.find_or_create_by!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter_3.id)

@pet_4 = Pet.find_or_create_by!(adoptable: true, age: 7, breed: 'sphynx', name: 'Blake', shelter_id: @shelter_1.id)
@pet_5 = Pet.find_or_create_by!(adoptable: false, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
@pet_6 = Pet.find_or_create_by!(adoptable: true, age: 4, breed: 'sphynx', name: 'Jeremy', shelter_id: @shelter_3.id)
@pet_7 = Pet.find_or_create_by!(adoptable: true, age: 9, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)

@vet_office_1 = VeterinaryOffice.find_or_create_by!(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
@vet_office_2 = VeterinaryOffice.find_or_create_by!(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
@vet_office_3 = VeterinaryOffice.find_or_create_by!(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)


vet_1 = Veterinarian.find_or_create_by!(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office_1.id)
vet_2 = Veterinarian.find_or_create_by!(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_2.id)

@application = Application.find_or_create_by!(name: "Chaz Carmichael",
  street_address: "10 lane",
  city: "Sandy Springs",
  state: "CO",
  zipcode: 12345)


@pet_application = PetApplication.find_or_create_by!(application_id: @application.id, pet_id: @pet_1.id)
@pet_application1 = PetApplication.find_or_create_by!(application_id: @application.id, pet_id: @pet_2.id)

@application.id = 1
@application.status = "1"
@application.save
