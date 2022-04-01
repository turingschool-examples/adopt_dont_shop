# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Shelter.destroy_all
Pet.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
application = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd", city: "Denver", state: "CO", zipcode: "80123")
shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
pet_1 = shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
