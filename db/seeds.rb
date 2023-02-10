# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create!(name: "Dumb Friends League", foster_program: yes, city: "Denver", rank: "1")
shelter_2 = Shelter.create!(name: "Humane Society", foster_program: no, city: "Aurora", rank: "2")
shelter_3 = Shelter.create!(name: "Max Fund", foster_program: yes, city: "Denver", rank: "3")

pet_1 = Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry")
pet_1 = Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 1, breed: "Boston Terrier", name: "Max")
pet_1 = Pet.create!(shelter_id: shelter_1.id, adoptable: false, age: 4, breed: "Soft Coated Wheaton Terrier", name: "Daisy")

pet_1 = Pet.create!(shelter_id: shelter_2.id, adoptable: false, age: 4, breed: "Pit Bull", name: "Sally")
pet_1 = Pet.create!(shelter_id: shelter_2.id, adoptable: false, age: 3, breed: "Poodle", name: "Joey")
pet_1 = Pet.create!(shelter_id: shelter_2.id, adoptable: true, age: 2, breed: "Golden Retriever", name: "Spot")

pet_1 = Pet.create!(shelter_id: shelter_3.id, adoptable: false, age: 4, breed: "Soft Coated Wheaton Terrier", name: "Sal")
pet_1 = Pet.create!(shelter_id: shelter_3.id, adoptable: true, age: 2, breed: "Golden Doodle", name: "Barbara")
pet_1 = Pet.create!(shelter_id: shelter_3.id, adoptable: true, age: 1, breed: "French Bull Dog", name: "Gabby")