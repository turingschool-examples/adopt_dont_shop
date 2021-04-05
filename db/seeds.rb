# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create!(foster_program: true, name: "Portland Animal Rescue", city: "Portland, OR", rank: 1)
pet_1 = Pet.create!(name: "Cowboy", age: 1, adoptable: true, breed: "russian blue", shelter_id: shelter_1.id)
application_1 = Application.create!(name: "Alan Smithee", address: "742 Evergreen Terrace Springfield, OR 97205", description: "Looking for a lockdown companion", status: "In progress")




