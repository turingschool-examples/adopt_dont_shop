# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create!(
    foster_program: true, 
    name: "Aspen Grove", 
    city: "Fort Collins", 
    rank: 1)
 pet_3 = Pet.create!(
    adoptable: true, 
    age: 14, 
    breed: "Chihuahua", 
    name: "Eleanor", 
    shelter_id: shelter_1.id)