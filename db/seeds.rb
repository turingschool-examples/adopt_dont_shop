# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@shelter1 = Shelter.create!(name: "Oregon's Shady Shelter", city: "Portland", rank: 4, foster_program: true)
@shelter2 = Shelter.create!(name: "Denver's Questionable Shelter", city: "Denver", rank: 5, foster_program: false)
@shelter3 = Shelter.create!(name: "Elon's Space Pets", city: "Moon City", rank: 3, foster_program: false)
@shelter4 = Shelter.create!(name: "Corgi Shelter Sanctuary", city: "Aurora", rank: 2, foster_program: true)
@shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)


@pet1 = @shelter1.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
@pet2 = @shelter1.pets.create!(name: "Twiggy", breed: "Ant Eater", age: 6, adoptable: true)
@pet3 = @shelter2.pets.create!(name: "Momo", breed: "Miniature Pony", age: 5, adoptable: false)
@pet4 = @shelter2.pets.create!(name: "Loki", breed: "Bronco", age: 7, adoptable: true)
@pet5 = @shelter3.pets.create!(name: "Diamond", breed: "Silverback", age: 12, adoptable: false)
@pet6 = @shelter3.pets.create!(name: "Rico", breed: "Chimpanzee", age: 10, adoptable: false)
@pet7 = @shelter4.pets.create!(name: "Ruby", breed: "Pembroke", age: 6, adoptable: true)
@pet8 = @shelter4.pets.create!(name: "Penny", breed: "Cardigan", age: 8, adoptable: true)
@pet9 = @shelter5.pets.create!(name: "Leonardo", breed: "Pizza Turtle", age: 23, adoptable: true)
@pet10 = @shelter5.pets.create!(name: "Raphael", breed: "Sewer Turle", age: 43, adoptable: true)
