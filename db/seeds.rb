# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
special_friends = VeterinaryOffice.create(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
pet_emergency_room = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
the_country_vet = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)

special_friends.veterinarians.create(name: 'Morgan', on_call: true, review_rating: 10)
special_friends.veterinarians.create(name: 'Heather', on_call: true, review_rating: 9)
the_country_vet.veterinarians.create(name: 'John', on_call: true, review_rating: 9)

aurora_shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
rgv_animal_shelter = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
fancy_pets_of_colorado = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

aurora_shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
aurora_shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
fancy_pets_of_colorado.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)