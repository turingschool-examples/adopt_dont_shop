# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter_1 = Shelter.create!(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
@shelter_2 = Shelter.create!(name: 'Heavenly pets', city: 'Denver, CO', foster_program: true, rank: 7)
@shelter_3 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_4 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)

@shelter_1.pets.create!(adoptable: true, age: 5, breed: 'tuxedo shorthair', name: 'Mr. Pirate', shelter_id: @shelter_1.id)
@shelter_1.pets.create!(adoptable: true, age: 3, breed: 'shorthair', name: 'Clawdia', shelter_id: @shelter_1.id)
@shelter_2.pets.create!(adoptable: true, age: 8, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_2.id)
@shelter_2.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_2.id)
@shelter_3.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_3.id)
@shelter_3.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: @shelter_3.id)
@shelter_4.pets.create!(adoptable: false, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: @shelter_4.id)
@shelter_4.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: @shelter_4.id)


@vet_office_1 = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
@vet_office_2 = VeterinaryOffice.create!(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 5)
@vet_office_3 = VeterinaryOffice.create!(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
@vet_office_4 = VeterinaryOffice.create!(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)

@vet_office_1.veterinarians.create!(name: 'Morgan', on_call: true, review_rating: 10, veterinary_office_id: @vet_office_1.id)
@vet_office_1.veterinarians.create!(name: 'Heather', on_call: true, review_rating: 9, veterinary_office_id: @vet_office_1.id)
@vet_office_2.veterinarians.create!(name: 'John', on_call: true, review_rating: 9, veterinary_office_id: @vet_office_2.id)
@vet_office_2.veterinarians.create!(name: 'Kelsey', on_call: true, review_rating: 9, veterinary_office_id: @vet_office_2.id)
@vet_office_3.veterinarians.create!(name: 'Taylor', on_call: false, review_rating: 10, veterinary_office_id: @vet_office_3.id)
@vet_office_3.veterinarians.create!(name: 'Taylor', on_call: true, review_rating: 10, veterinary_office_id: @vet_office_3.id)
@vet_office_4.veterinarians.create!(name: 'Jim', on_call: true, review_rating: 8, veterinary_office_id: @vet_office_4.id)
@vet_office_4.veterinarians.create!(name: 'Shannon', on_call: true, review_rating: 9, veterinary_office_id: @vet_office_4.id)
