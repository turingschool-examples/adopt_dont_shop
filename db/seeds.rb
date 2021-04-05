# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create!(name: 'Portland Animal Rescue', city: 'Portland, OR', foster_program: true, rank: 1)
shelter_2 = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

pet_1 = Pet.create(adoptable: true, age: 1, breed: 'Russian Blue', name: 'Cowboy', shelter_id: shelter_1.id)
pet_2 = Pet.create(adoptable: true, age: 1, breed: 'Sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
pet_3 = Pet.create(adoptable: true, age: 3, breed: 'Doberman', name: 'Lobster', shelter_id: shelter_2.id)

application_1 = Application.create!(name: "Alan Smithee", address: "742 Evergreen Terrace Springfield, OR 97205", description: "Looking for a lockdown companion", status: "In progress")




