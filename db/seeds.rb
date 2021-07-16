# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all
Pet_Application.destroy_all
Application.destroy_all

brighter_days = Shelter.create!(name: 'Brighter Days Shelter', rank: 1, city: 'boulder', foster_program: true)
underdogs = Shelter.create!(name: 'Underdogs Shelter', rank: 2, city: 'denver', foster_program: true)

brighter_days.pets.create!(name: 'Bosco', adoptable: true, age: 8, breed: 'Springer Spaniel')
brighter_days.pets.create!(name: 'Lily', adoptable: true, age: 5, breed: 'German Shepard Boxer Mix')
brighter_days.pets.create!(name: 'Leia', adoptable: true, age: 6, breed: 'Bernadoodle')
brighter_days.pets.create!(name: 'Toby', adoptable: true, age: 3, breed: 'Chocolate Lab')
brighter_days.pets.create!(name: 'Beans', adoptable: true, age: 8, breed: 'German Shepard')
shelter.pets.create!(name: 'Izze', adoptable: true, age: 8, breed: 'Cocker Spaniel')
shelter.pets.create!(name: 'Zephyr', adoptable: true, age: 8, breed: 'Malamute')
shelter.pets.create!(name: 'Ruger', adoptable: true, age: 8, breed: 'Husky Samoyed Mix')
shelter.pets.create!(name: 'Clyde', adoptable: true, age: 8, breed: 'Boxer')
shelter.pets.create!(name: 'Jasmine', adoptable: true, age: 8, breed: 'Black Lab')
shelter.pets.create!(name: 'Finn', adoptable: true, age: 8, breed: 'Australian Shepard')
