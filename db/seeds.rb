# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

application_1 = Application.create!(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", description: "I'd be good because I love pets", application_status: "pending")

shelter_1 = Shelter.create!(foster_program: 'true', name: "Shelter 1", city: "Denver", rank: "5")
shelter_2 = Shelter.create!(foster_program: 'true', name: "Bradburn Shelter", city: "Denver", rank: "1")
shelter_3 = Shelter.create!(foster_program: 'true', name: "Home 4 Cats", city: "Denver", rank: "1")

pet_1 = application_1.pets.create!(adoptable: "true", age: "3", breed: "Terrier", name: "Sparky", shelter_id: "#{shelter_1.id}")

pet_2 = Pet.create!(adoptable: "true", age: "1", breed: "Black Lab", name: "Spot", shelter_id: "#{shelter_1.id}")

pet_3 = Pet.create!(adoptable: "true", age: "6", breed: "Yellow Lab", name: "Bow Wow", shelter_id: "#{shelter_1.id}")

pet_4 = Pet.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "Sprechen", shelter_id: "#{shelter_1.id}")
