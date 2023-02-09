# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
Pet.destroy_all

Application.create!(name: 'Bobby Lully', address: '123 Sesame Street, Denver, CO 12345', description: "I need a friend", pets: "Scooby", status: "Pending")

Shelter.create!(foster_program: false, name: "The Farm", city: "Denver", rank: 2)

Pet.create!(adoptable: true, age: 1, breed: "Great Dane", shelter_id: 1, name: 'Scooby', )
