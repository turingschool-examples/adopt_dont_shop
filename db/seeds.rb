# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create!(foster_program: true, name: "Best Shelter", city: "Daytona", rank: 4)
application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "I really love dogs", status: "Pending")
pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "Labradoodle", name: "Leo")
PetApplication.create!(application: @application_1, pet: @pet_1)
PetApplication.create!(application: @application_1, pet: @pet_2)
