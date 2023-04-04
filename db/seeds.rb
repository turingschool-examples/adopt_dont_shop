# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
<<<<<<< Updated upstream

=======
# PetApplication.destroy_all
# Pet.destroy_all
# Application.destroy_all
# Shelter.destroy_all
>>>>>>> Stashed changes


@shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
@shelter_2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Sky City", rank: 30)
@shelter_3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Sky City", rank: 40)
@shelter_4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Sky City", rank: 50)
@pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
@pet_2 = @shelter_2.pets.create!(name: "Bento", age: 23, breed: "dog")
@pet_3 = @shelter_3.pets.create!(name: "Quiggle", age: 555,)
@pet_4 = @shelter_4.pets.create!(name: "Simpleton", age: 80,)
@pet_5 = @shelter_1.pets.create!(name: "Snapchat", age: 799,)
@application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
@application_2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
@application_3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
PetApplication.create!(pet_id: @pet_5.id, application_id: @application_1.id)
PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id)
PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id)
PetApplication.create!(pet_id: @pet_4.id, application_id: @application_3.id)
PetApplication.create!(pet_id: @pet_5.id, application_id: @application_3.id)