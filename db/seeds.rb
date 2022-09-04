# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@craigs = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha")
@aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

@pet_1 = @craigs.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
@pet_2 = @craigs.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
@pet_3 = @aurora.pets.create!(adoptable: true, name: "Eggs Sinclair", age: 10, breed: "Tres Marias")
@pet_4 = @aurora.pets.create!(adoptable: true, name: "Monster Truck Wendy", age: 5, breed: "Vancouver Island")

@app = App.create!(
  name: "Gob Beldof", 
  address: "152 Animal Ave.", 
  city: "Omaha", 
  state: "NE", 
  zip_code: "19593",
  description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
  status: "In Progress"
)

@app.pets << @pet_2
@app.pets << @pet_3