# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

ApplicationPet.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all


@shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 8)
@shelter_3 = Shelter.create!(name: 'Gunnison shelter', city: 'Gunnison, CO', foster_program: false, rank: 7)

@pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter_1.id)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
@pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
@pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter_1.id)
@pet_5 = Pet.create!(adoptable: true, age: 102, breed: 'tortoise', name: 'Tony', shelter_id: @shelter_2.id)
@pet_6 = Pet.create!(adoptable: true, age: 3, breed: 'terrier', name: 'Howie', shelter_id: @shelter_1.id)

@application_1 = Application.create!(first_name: "Jon", last_name: "Duttko", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, home_description: "friendly", status: "Pending")
@application_2 = Application.create!(first_name: "Noah", last_name: "van Ekdom", str_address: "3031 Beech St NW", city: "Washington", state: "DC", zip: 20015, home_description: "fenced in yard", status: "Pending")
@application_3 = Application.create!(first_name: "Samwise", last_name: "Gamgee", str_address: "3 Bagshot Row", city: "Bag End", state: "CO", zip: 80224, home_description: "hobbit lyfe", status: "In Progress")

@application_1.pets << @pet_1

@application_2.pets << @pet_1
@application_2.pets << @pet_2



# @application_1 = Application.create!(name: , address: , description: , pets_applied_for: , status: )

