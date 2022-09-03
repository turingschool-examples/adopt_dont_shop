# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
saving_pets_shelter = Shelter.create!(name: "Saving Pets Shelter", foster_program: true, city: "New York", rank: 3)
the_best_shelter = Shelter.create!(name: "The Best Shelter", foster_program: true, city: "New Orleans", rank: 3)
dumb_friends_shelter = Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: 3)

fluffy = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
fluffy2 = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 10, breed: "pomeranian")

pet1 = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
pet2 = saving_pets_shelter.pets.create!(name: "Floofy", adoptable: true, age: 7, breed: "mixed breed")
pet3 = saving_pets_shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")
pet4 = saving_pets_shelter.pets.create!(name: "Fluffy", adoptable: true, age: 10, breed: "pomeranian")
pet5 = the_best_shelter.pets.create!(name: "Mr. FLUFF", adoptable: true, age: 4, breed: "cockerspaniel")
pet6 = dumb_friends_shelter.pets.create!(name: "Ellie", adoptable: true, age: 1, breed: "pit bull")

samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")

#fluffy_application = PetApplication.create!(pet: fluffy, application: samantha_application)
