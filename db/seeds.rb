# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Application.destroy_all
Pet.destroy_all
AdoptablePet.destroy_all
shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
pet_2 = Pet.create!(name: 'Lobster', age: 3, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
application = pet_1.applications.create(name: 'Frank', street_address: '123 Main St', city: 'Long Beach', state: 'CA', zipcode: '90712', description: 'I have a fully fenced in acre property', status: 'pending')
AdoptablePet.create!(application: application, pet: pet_2)
