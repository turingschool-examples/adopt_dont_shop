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
@eggs = @craigs.pets.create!(adoptable: true, name: "Eggs Sinclair", age: 10, breed: "Tres Marias")
@wendy = @craigs.pets.create!(adoptable: true, name: "Monster Truck Wendy", age: 5, breed: "Vancouver Island")
@grom = @craigs.pets.create!(adoptable: true, name: "Grom the Paunch", age: 6, breed: "Cacomistle")
@ken = @fontaine.pets.create!(adoptable: true, name: "Big Paws Ken", age: 5, breed: "Western Lowland Olingo")
@gertrude = @fontaine.pets.create!(adoptable: true, name: "Petunia", age: 7, breed: "Ring-tailed Cat")
@sally = @fontaine.pets.create!(adoptable: true, name: "Fightin' Sally", age: 9, breed: "South American Coati")
@oat = @fontaine.pets.create!(adoptable: true, name: "Oatheart MacDentures", age: 2, breed: "Kinkajou")
@marge = @fontaine.pets.create!(adoptable: true, name: "Growly Marge", age: 3, breed: "Olinguito")
@olaf = @fontaine.pets.create!(adoptable: true, name: "Olaf the Brave", age: 1, breed: "Eastern Lowland Olingo")


@beldof = @craigs.apps.create!(
  name: "Gob Beldof", 
  address: "152 Animal Ave.", 
  city: "Omaha, NE", 
  zip_code: "19593",
  status: "Pending"
)
@garbo = @craigs.apps.create!(
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

@laver = @fontaine.apps.create!(
  name: "Rod Laver",
  address: "asdgwe",
  city: "asd2e",
  zip_code: "ad23dfs",
  status: "In Progress",
)

@beldof.pets << @princess
@beldof.pets << @eggs
@beldof.pets << @trash
@beldof.pets << @wendy
