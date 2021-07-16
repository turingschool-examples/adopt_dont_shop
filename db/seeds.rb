# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

furry = Shelter.create!(name:'Furrry Shelter', foster_program: true, city: 'New Orleans', rank: 5)
small = Shelter.create!(name:'Small Friends Shelter', foster_program: false, city: 'Atlanta', rank: 2)
paws = Shelter.create!(name: 'Dirty Paws Home', foster_program: true, city: 'Kansas City', rank: 4)

bruce = furry.pets.create!(name: 'Bruce', age: 3, adoptable: true, breed: 'black lab')
lana = furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')
doc = furry.pets.create!(name: 'Doc', age: 8, adoptable: true, breed: 'schnauzer')

oink = small.pets.create!(name: 'Oink', age: 2, adoptable: true, breed: 'hedge hog')
rollo = small.pets.create!(name: 'Rollo', age: 3, adoptable: true, breed: 'hamster')
pinky = small.pets.create!(name: 'Pink', age: 1, adoptable: true, breed: 'weasel')

buster = paws.pets.create!(name: 'Buster', age: 5, adoptable: true, breed: 'St. Bernard')
addie = paws.pets.create!(name: 'Addie', age: 2, adoptable: true, breed: 'long-haired')
lily = paws.pets.create!(name: 'Lily', age: 10, adoptable: true, breed: 'Maltese')

application1 = Application.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I love my furry friends and have a great yard they can roam around in', status: 'pending')
application2 = Application.create!(name: 'Amanda', street_address: '9892 Colorado Blvd.', city: 'Fargo', state: 'ND', zip_code:74563, home_description: 'Cuddles, pets, and long walks are my favorite things.', status: 'pending')
application3 = Application.create!(name: 'Bob', street_address: '123 Builders Lane', city: 'Las Vegas', state: 'NV', zip_code: 99298, home_description: 'I just lost my dog and looking for another', status: 'pending')
application4 = Application.create!(name: 'Scott', street_address: '4425 Hatters Dr.', city: 'New Orleans', state: 'LA', zip_code: 65356, home_description: 'Hiking and camping are my favorites', status: 'pending')

application1.pets << [buster, doc, pinky]
application2.pets << [lily]
application4.pets << [lana, bruce, rollo, addie]
