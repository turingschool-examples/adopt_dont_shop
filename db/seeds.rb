# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
PetApplication.destroy_all
@application = Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals') 
@application_2 = Application.create!(name: 'John', address: '123 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 'Pending')
@application_3 = Application.create!(name: 'Jane', address: '123 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 'Pending')
@shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
@shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9)
@shelter_3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
@bella = @shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) 
@rigby = @shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) 
@luna = @shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) 
@jimmy = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)