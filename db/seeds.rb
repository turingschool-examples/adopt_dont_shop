# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Shelter.destroy_all
Pet.destroy_all
Applicant.destroy_all

@shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
@applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver', state: 'CO', zip: 80205, description: "I'm awesome", status: 'pending')
@pet = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
@pet_2 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
