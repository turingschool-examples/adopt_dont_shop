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
ApplicationPet.destroy_all

@shelter = Shelter.create!(name: 'Cheyenne Animal Shelter', city: 'Cheyenne', foster_program: false, rank: 2)
@pet_1 = @shelter.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true, shelter_id: @shelter.id)
@pet_2 = @shelter.pets.create!(name: 'Bianca', age: 1, breed: 'Great Pyrenees',  adoptable: true, shelter_id: @shelter.id)
@app_1 = Application.create!(
  name: "Sarah Carter",
  address: "1108 Ichabod St",
  city: "North Pole",
  state: "Alaska",
  zip: "99705",
  description: "I will name him George, and I will hug him, and pet him, and squeeze him")
@app_2 = Application.create!(
  name: "Doug Olson",
  address: "2866 Villalobos Ave",
  city: "North Pole",
  state: "Alaska",
  zip: "99705",
  description: "Really more of a cat person but dogs are okay...I guess."
)
