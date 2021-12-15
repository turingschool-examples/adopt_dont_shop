# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.destroy_all
ApplicationForm.destroy_all
Pet.destroy_all
Shelter.destroy_all

@shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@pet_1 = Pet.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter_1.id)
@pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_1.id)
@pet_3 = Pet.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: true, shelter_id: @shelter_1.id)

@application_form_1 = ApplicationForm.create!(name: "Joe Shmoe", street_address: '123 Commerce St', city: "Bridgeton", state: "NJ", zip_code: "08302", description: "I don't know", status: "In Progress")

# @shelter_2 = Shelter.create!(name: 'Beverly Hills shelter', city: 'Beverly Hills, CA', foster_program: false, rank: 10)
# @pet_4 = @shelter_2.pets.create!(name: 'Mr. Doubtfire', breed: 'wiredhair', age: 2, adoptable: false)
# @pet_5 = @shelter_2.pets.create!(name: 'Damion', breed: 'retriever', age: 4, adoptable: true)
# @pet_6 = @shelter_2.pets.create!(name: 'SANADA', breed: 'tabby', age: 7, adoptable: true)
