# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@jimmy_application = Application.create!(name: 'Jimmy John', street_address: '303 Broadway', city: 'Denver', state: 'CO', zip_code: 80122, description: 'I would love to have a companion', status: 'In Progress')
@shelter = Shelter.create!(foster_program: true, name: "Sara's Safehouse", city: 'Inglewood', rank: 3)
@fido = Pet.create!(adoptable: true, age: 3, breed: 'dog', name: 'Fido', shelter_id: @shelter.id)
@purrs = Pet.create!(adoptable: true, age: 10, breed: 'cat', name: 'Purrs', shelter_id: @shelter.id)
@baldy = Pet.create!(adoptable: true, age: 9, breed: 'cat', name: 'Baldy', shelter_id: @shelter.id)
PetApplication.create!(application: @jimmy_application, pet: @fido)
PetApplication.create!(application: @jimmy_application, pet: @purrs)