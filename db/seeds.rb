# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

fred = shelter.pets.create!(adoptable: true, age: 8, breed: 'Basset Hound', name: 'Fred')
james = shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
buster = shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
marlowe = shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

app1 = Application.create!(name: 'Frank Sinatra', street_address: '69 Sinatra Way', city: 'Nashville', state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs", status: 'In Progress')

PetApplication.create!(pet: buster, application: app1)
PetApplication.create!(pet: marlowe, application: app1)