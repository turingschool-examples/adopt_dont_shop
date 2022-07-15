# This file should contain all the record creant needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicantPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Applicant.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
pet_2 = shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

bob_1 = Applicant.create(name: "Billy Bob", address: "Street address 6093", description: "I'm bob", status: "Pending", zip: 22323, city: "denver", state: "CO")
bob_2 = Applicant.create(name: "Freiza", address: "Acne Lane 80422", description: "I'm freiza 2", status: "Rejected", zip: 80029, city: "denver", state: "CO")
bob_3 = Applicant.create(name: "James Maddy", address: "Street address 6093", description: "I'm bob", status: "Accepted", zip: 31123, city: "denver", state: "CO")

app_1 = ApplicantPet.create(applicant: bob_1, pet: pet_1)
app_2 = ApplicantPet.create(applicant: bob_1, pet: pet_4)
app_3 = ApplicantPet.create(applicant: bob_2, pet: pet_2)
app_4 = ApplicantPet.create(applicant: bob_3, pet: pet_3)
