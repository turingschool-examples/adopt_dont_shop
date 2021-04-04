# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'faker'

Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all

# Shelters
aurora_shelter = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 3)
co_humane_society = Shelter.create!(name: 'The Colorado Humane Society', city: 'Denver, CO', foster_program: false, rank: 5)
foothills_shelter = Shelter.create!(name: 'Foothills Animal Shelter', city: 'Golden, CO', foster_program: true, rank: 4)
humane_society_boulder = Shelter.create!(name: 'Humane Society of Boulder Valley', city: 'Boulder, CO', foster_program: false, rank: 5)
animal_rescue_rockies = Shelter.create!(name: 'Animal Rescue of the Rockies', city: 'Denver, CO', foster_program: true, rank: 4)
denver_animal_shelter = Shelter.create!(name: 'Denver Animal Shelter', city: 'Denver, CO', foster_program: true, rank: 4)

# Pets
aurora_shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
aurora_shelter.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
aurora_shelter.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

co_humane_society.pets.create!(name: 'Link', breed: 'dachshund', age: 1, adoptable: true)
co_humane_society.pets.create!(name: 'Tofu', breed: 'boxer', age: 1, adoptable: true)
co_humane_society.pets.create!(name: 'Theo', breed: 'labrador retriever', age: 4, adoptable: true)

foothills_shelter.pets.create!(name: 'Ramone', breed: 'hound', age: 2, adoptable: true)
foothills_shelter.pets.create!(name: 'Lawson', breed: 'Australian shepherd', age: 6, adoptable: true)
foothills_shelter.pets.create!(name: 'Petunia', breed: 'chihuahua', age: 1, adoptable: true)

humane_society_boulder.pets.create!(name: 'Emma', breed: 'beagle', age: 1, adoptable: true)
humane_society_boulder.pets.create!(name: 'Odessa', breed: 'border terrier', age: 6, adoptable: true)

animal_rescue_rockies.pets.create!(name: 'Bear', breed: 'flat-coated retriever', age: 0, adoptable: true)
animal_rescue_rockies.pets.create!(name: 'Six', breed: 'great pyrenees', age: 0, adoptable: true)
animal_rescue_rockies.pets.create!(name: 'Eddie', breed: 'pit bull terrier', age: 3, adoptable: true)

denver_animal_shelter.pets.create!(name: 'Leia', breed: 'pit bull terrier', age: 4, adoptable: true)
denver_animal_shelter.pets.create!(name: 'Josh', breed: 'Australian shepherd', age: 3, adoptable: true)
denver_animal_shelter.pets.create!(name: 'Maisie', breed: 'American staffordshire terrier', age: 1, adoptable: true)
denver_animal_shelter.pets.create!(name: 'Rug', breed: 'mixed', age: 3, adoptable: true)
denver_animal_shelter.pets.create!(name: 'Waffles', breed: 'hound', age: 2, adoptable: true)


######################

# Veterinary Offices
best_vets = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
ok_vets = VeterinaryOffice.create!(name: 'OK Vets', boarding_services: true, max_patient_capacity: 15)

# Veterinarians
best_vets.veterinarians.create!(name: 'Taylor', review_rating: 10, on_call: true)
best_vets.veterinarians.create!(name: 'Tanya', review_rating: 9, on_call: true)
best_vets.veterinarians.create!(name: 'Jim', review_rating: 8, on_call: true)
best_vets.veterinarians.create!(name: 'Sam', review_rating: 10, on_call: false)

ok_vets.veterinarians.create!(name: 'Jerry', review_rating: 5, on_call: false)
ok_vets.veterinarians.create!(name: 'Nina', review_rating: 6, on_call: true)
