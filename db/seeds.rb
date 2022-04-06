# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

#veterinary offices
@vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
@vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)

#vets
@vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office_1.id)
@vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_1.id)
@vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: @vet_office_2.id)
#not on call vet
@not_on_call_vet = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: @vet_office_1.id)

#shelters
@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
@shelter_4 = Shelter.create(name: 'This is a Shelter', city: 'Denver, CO', foster_program: true, rank: 11, full_address: "2438 Drive St, Denver, CO, 98542")




#pets - not tied to application yet
@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
@pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
@pet_5 = @shelter_4.pets.create(name: 'Ruby', breed: 'mut', age: 5, adoptable: true)

#pets - currently on applications
@shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@lobster = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
@skeeter = Pet.create!(adoptable: true, age: 7, breed: 'corgie', name: 'Skeeter', shelter_id: @shelter_1.id)
@skippy = Pet.create!(adoptable: true, age: 5, breed: 'lab', name: 'skippy', shelter_id: @shelter_3.id)

#applications w/o pets or description them (status: 0)
@craig = Application.create!(name: 'Craig', address: '150 south street, Aurora, CO, 80014', description: '', pet_names: "", status: 0)
@alex = Application.create!(name: 'Alex', address: '23984 Street Dr, Evergreen, CO, 80439', description: '', pet_names: "", status: 0)



#applications with pets on them and description (status:1)
@bonds = Application.create!(name: 'Barry Bonds', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@skeeter.id}, #{@lobster.id}", status: 1)
@sosa = Application.create!(name: 'Sammy Sosa', address: '32084 Other street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@skeeter.id}, #{@lobster.id}", status: 1)

#application_pets
@app_pet1 = ApplicationPet.create!(application: @bonds, pet: @skeeter, pet_status: 0)
@app_pet2 = ApplicationPet.create!(application: @bonds, pet: @lobster, pet_status: 0)

@app_pet3 = ApplicationPet.create!(application: @sosa, pet: @skeeter, pet_status: 0)
@app_pet4 = ApplicationPet.create!(application: @sosa, pet: @lobster, pet_status: 0)
@app_pet5 = ApplicationPet.create!(application: @sosa, pet: @pet_5, pet_status: 0)
