# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@craigs = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE", foster_program: 'false')
@aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@fontaine = Shelter.create!(name: 'Fontainebleu Institute of Varmint Husbandry', city: 'Golden, CO', foster_program: true, rank: 6)
@damon = Shelter.create!(name: 'Matt Damon Memorial Rodent Hotel', city: 'Boulder, CO', foster_program: false, rank: 3)

@trash = @craigs.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
@princess = @craigs.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
@eggs = @aurora.pets.create!(adoptable: true, name: "Eggs Sinclair", age: 10, breed: "Tres Marias")
@wendy = @aurora.pets.create!(adoptable: true, name: "Monster Truck Wendy", age: 5, breed: "Vancouver Island")

@beldof = @craigs.apps.create!(
  name: "Gob Beldof", 
  address: "152 Animal Ave.", 
  city: "Omaha, NE", 
  zip_code: "19593",
  status: "Pending"
)
@garbo = @aurora.apps.create!(
  name: "Luut Garbo",
  address: "asdf",
  city: "asdfa",
  zip_code: "asdfs",
  status: "Pending",
)

@smooch = @fontaine.apps.create!(
  name: "Carter Smooch",
  address: " asdgw",
  city: "asdgwe",
  zip_code: "agwef",
  status: "Pending",
)

@laver = @damon.apps.create!(
  name: "Rod Laver",
  address: "asdgwe",
  city: "asd2e",
  zip_code: "ad23dfs",
  status: "In Progress",
)

@beldof.pets << @princess
@beldof.pets << @eggs