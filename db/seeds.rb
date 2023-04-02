# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './spec/fixtures/veterinary_office_data'
require './spec/fixtures/veterinarian_data'
require './spec/fixtures/application_data'
require './spec/fixtures/pet_data'
require './spec/fixtures/shelter_data'

include VeterinaryOfficeData
include VeterinarianData
include ApplicationData
include PetData
include ShelterData

VeterinaryOffice.destroy_all
Veterinarian.destroy_all
PetApplication.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

vet_office_1 = VeterinaryOffice.create(OFFICE_1)
vet_office_2 = VeterinaryOffice.create(OFFICE_2)
vet_office_3 = VeterinaryOffice.create(OFFICE_3)

vet_1 = vet_office_1.veterinarians.create(VET_1)
vet_2 = vet_office_1.veterinarians.create(VET_2)
vet_3 = vet_office_1.veterinarians.create(VET_3)
vet_4 = vet_office_1.veterinarians.create(VET_4)
vet_5 = vet_office_2.veterinarians.create(VET_5)
vet_6 = vet_office_2.veterinarians.create(VET_6)
vet_7 = vet_office_3.veterinarians.create(VET_7)

shelter_1 = Shelter.create(SHELTER_1)
shelter_2 = Shelter.create(SHELTER_2)
shelter_3 = Shelter.create(SHELTER_3)

pet_1 = shelter_1.pets.create(PET_1)
pet_2 = shelter_1.pets.create(PET_2)
pet_3 = shelter_1.pets.create(PET_3)
pet_4 = shelter_1.pets.create(PET_4)
pet_5 = shelter_1.pets.create(PET_5)
pet_6 = shelter_2.pets.create(PET_6)
pet_7 = shelter_3.pets.create(PET_7)
pet_8 = shelter_3.pets.create(PET_8)
pet_9 = shelter_3.pets.create(PET_9)
pet_10 = shelter_3.pets.create(PET_10)

app_1 = Application.create(APP_1)
app_2 = Application.create(APP_2)
app_3 = Application.create(APP_3)
app_4 = Application.create(APP_4)

PetApplication.create(application_id: app_2.id, pet_id: pet_2.id)
PetApplication.create(application_id: app_2.id, pet_id: pet_3.id)
PetApplication.create(application_id: app_2.id, pet_id: pet_1.id)
PetApplication.create(application_id: app_2.id, pet_id: pet_4.id)
PetApplication.create(application_id: app_3.id, pet_id: pet_7.id)
PetApplication.create(application_id: app_3.id, pet_id: pet_8.id)
PetApplication.create(application_id: app_3.id, pet_id: pet_1.id)
PetApplication.create(application_id: app_3.id, pet_id: pet_2.id)
PetApplication.create(application_id: app_4.id, pet_id: pet_9.id)
PetApplication.create(application_id: app_4.id, pet_id: pet_10.id)
PetApplication.create(application_id: app_4.id, pet_id: pet_7.id)
PetApplication.create(application_id: app_4.id, pet_id: pet_8.id)
