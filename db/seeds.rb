# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Shelter.destroy_all
Pet.destroy_all
Applicant.destroy_all

@shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver',
  state: 'CO', zip: 80205, description: "I'm awesome", status: 'pending')
@applicant_1 = Applicant.create!(first_name: 'Jimmy', last_name: 'Dough', street_address: '567 Fake Street', city: 'Denver',
  state: 'CO', zip: 80205, description: "I'm awesome", status: 'Pending')
@applicant_2 = Applicant.create!(first_name: 'Johnny', last_name: 'Johnson', street_address: '17 Psuedo Street', city: 'Denver',
  state: 'CO', zip: 80205, description: "I'm awesome", status: 'In Progress')
@applicant_3= Applicant.create!(first_name: 'Timmy', last_name: 'Thompson', street_address: '57 Real Street', city: 'Denver',
  state: 'CO', zip: 80207, description: "I'm not so awesome", status: 'Pending')
@applicant_4= Applicant.create!(first_name: 'Tommy', last_name: 'Timson', street_address: '12227 Real Blvd', city: 'Colorado Springs',
  state: 'CO', zip: 80909, description: "I'm the worst", status: 'Approved')

@pet = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
@pet_1 = @applicant_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false, shelter_id: @shelter_1.id)
@pet_2 = @applicant_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_2.id)
@pet_3 = @applicant_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_3.id)
@pet_4 = @applicant_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true, shelter_id: @shelter_1.id)
@pet_5 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter_1.id)
