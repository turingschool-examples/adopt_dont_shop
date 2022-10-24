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
@pet10 = @shelter5.pets.create!(name: "Raphael", breed: "Sewer Turtle", age: 43, adoptable: true)
@pet11 = @shelter5.pets.create!(name: "Leonard", breed: " Turtle", age: 47, adoptable: true)
@pet12 = @shelter5.pets.create!(name: "Ralph", breed: "Lizard", age: 6, adoptable: false)

@app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own")
@app2 = Applicant.create!(name: "Kevin Ta", street_address: "2208 Repeater Dr", city: "Aurora", state: "CO", zip_code: "80011", description: "I love Corgi's, can I haz?")
@app3 = Applicant.create!(name: "Abdul Redd", street_address: "333 Ruby Rails Ct", city: "Miami", state: "FL", zip_code: "96352", description: "Tired of Students, want a pet that can learn properly")


@pet_app1 = PetApplicant.create!(pet_id: @pet1.id, applicant_id: @app1.id)
@pet_app2 = PetApplicant.create!(pet_id: @pet4.id, applicant_id: @app1.id)
@pet_app3 = PetApplicant.create!(pet_id: @pet7.id, applicant_id: @app2.id)
@pet_app4 = PetApplicant.create!(pet_id: @pet8.id, applicant_id: @app2.id)
@pet_app5 = PetApplicant.create!(pet_id: @pet9.id, applicant_id: @app3.id)
@pet_app6 = PetApplicant.create!(pet_id: @pet10.id, applicant_id: @app3.id)