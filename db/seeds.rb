# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter1 = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
shelter2 = Shelter.create!(name: "Humane Society", city: "Salem", rank: 1, foster_program: true)
shelter3 = Shelter.create!(name: "High Desert Shelter", city: "Salem", rank: 3, foster_program: true)
pet_1 = shelter1.pets.create!(name: "Cozmo", age: 8, breed: 'Aussie', adoptable: true)
pet_2 = shelter2.pets.create!(name: "George", age: 11, breed: 'Dachshund', adoptable: true)
pet_3 = shelter3.pets.create!(name: "Hawk", age: 5, breed: 'Mini Aussie', adoptable: true)
application_1 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
application_2 = pet_2.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
application_3 = pet_3.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "In Progress")
