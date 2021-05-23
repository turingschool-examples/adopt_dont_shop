# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 Pet.destroy_all
 Shelter.destroy_all
 Veterinarian.destroy_all
 VeterinaryOffice.destroy_all
 PetApplication.destroy_all

dfl = Shelter.create!(name: 'Dumb Friends League', city: 'Denver', rank: 3, foster_program: true)
hs = Shelter.create!(name: 'Humane Society', city: 'Denver', rank: 4, foster_program: true)
ap = Shelter.create!(name: 'Angels with Paws', city: 'Denver', rank: 2, foster_program: false)

wanda = dfl.pets.create!(name: 'Wanda', age: 4, breed: 'rescue special cattle', adoptable: false)
dozer = dfl.pets.create!(name: 'Dozer', age: 7, breed: 'rescue special pit bull', adoptable: true)
jack = hs.pets.create!(name: 'Jack', age: 4, breed: 'rescue special cattle', adoptable: true)
smash = hs.pets.create!(name: 'Smash', age: 4, breed: 'orange cat', adoptable: false)
tiger = ap.pets.create!(name: 'Tiger', age: 4, breed: 'brown stripped cat', adoptable: true)
skittle = ap.pets.create!(name: 'Skittle', age: 4, breed: 'rat terrier', adoptable: true)

applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "", status: "Pending")


kvh = VeterinaryOffice.create!(name: 'Kipling Veterinary Hospital', max_patient_capacity: 5, boarding_services: false)
wah = VeterinaryOffice.create!(name: 'Wadsworth Animal Hospital', max_patient_capacity: 7, boarding_services: true)
aav = VeterinaryOffice.create!(name: 'Animal Ark Veterinary Clinic', max_patient_capacity: 3, boarding_services: true)

sidel = kvh.veterinarians.create!(name: 'Dr. Sidel', review_rating: 5, on_call: false)
pepper = kvh.veterinarians.create!(name: 'Dr. Pepper', review_rating: 4, on_call: true)
love = wah.veterinarians.create!(name: 'Dr. Love', review_rating: 3, on_call: false)
scott = wah.veterinarians.create!(name: 'Dr. Scott', review_rating: 2, on_call: true)
phill = aav.veterinarians.create!(name: 'Dr. Phill', review_rating: 4, on_call: true)
girlfriend = aav.veterinarians.create!(name: 'Dr. Girlfriend', review_rating: 5, on_call: false)
