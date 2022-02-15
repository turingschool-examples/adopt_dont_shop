# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all

dfl = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Denver", rank: 53)
spike = dfl.pets.create!(adoptable: true, age: 1, breed: "Golden Retriever", name: "Spike")
cat = dfl.pets.create!(adoptable: true, age: 2, breed: "Siamesse", name: "Meow")
ninja = dfl.pets.create!(adoptable: true, age: 2, breed: "Son Conior", name: "Ninja")
spot = dfl.pets.create!(adoptable: true, age: 2, breed: "Lab", name: "Spot")
