# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

furry_friends = Shelter.create!(name: "Furry Friends", foster_program: true, city: "Denver", rank: "2")

dogs_and_cats = Shelter.create!(name: "Dogs and Cats", foster_program: true, city: "Richmond", rank: "3")

cats_only = Shelter.create!(name: "Cats Only", foster_program: true, city: "Boise", rank: "4")

farm_animals = Shelter.create!(name: "Farm Animals", foster_program: false, city: "Kansas City", rank: "5")

olive = furry_friends.pets.create!(name: "Olive", age: 2, breed: "dog", adoptable: true)

ozzy = furry_friends.pets.create!(name: "Ozzy", age: 1, breed: "dog", adoptable: true)

hank = dogs_and_cats.pets.create!(name: "Hank", age: 3, breed: "dog", adoptable: true)

jake = dogs_and_cats.pets.create!(name: "Jake", age: 5, breed: "cat", adoptable: true)

buddy = cats_only.pets.create!(name: "Buddy", age: 5, breed: "cat", adoptable: true)

rick_owens = cats_only.pets.create!(name: "Rick Owens", age: 5, breed: "cat", adoptable: true)

bobby = farm_animals.pets.create!(name: "Bobby", age: 5, breed: "cow", adoptable: true)

grumpy = farm_animals.pets.create!(name: "Grumpy", age: 2, breed: "goat", adoptable: true)

application_1 = Application.create!(name: "Hiroko Matsushita", street_address: "123 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")


application_2 = Application.create!(name: "Mihara Yasuhiro", street_address: "234 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")

application_3 = Application.create!(name: "Steve Jobs", street_address: "456 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")


application_4 = Application.create!(name: "Marky Mark", street_address: "678 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")



pet_application_1 = PetApplication.create!(pet_id: grumpy.id, application_id: application_1.id)

pet_application_2 = PetApplication.create!(pet_id: bobby.id, application_id: application_1.id)

pet_application_3 = PetApplication.create!(pet_id: rick_owens.id, application_id: application_2.id)

pet_application_4 = PetApplication.create!(pet_id: rick_owens.id, application_id: application_3.id)

pet_application_5 = PetApplication.create!(pet_id: olive.id, application_id: application_4.id)
