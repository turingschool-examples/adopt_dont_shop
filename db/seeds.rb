# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
smithers_application = Application.create!(name: "Smithers", street_address: "99 Higgins Estate", city: "Springfield", state: "IL", zip_code: 90597, description: "I have a lot of land and no friends", status: "In Progress")
homer_application = Application.create!(name: "Homer", street_address: "24 East Ridge", city: "Springfield", state: "IL", zip_code: 90597, description: "since the drinking hole closed i have a lot of time on my hands and no friends", status: "In Progress")
shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
scooby = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
bolt = Pet.create!(name: "Bolt", age: 1, breed: "Chihuahua", adoptable: true, shelter_id: shelter.id)
barbados = Pet.create!(adoptable: true, age: 8, breed: 'poodle', name: 'Barbados', shelter_id: shelter.id)
pet_app_1 = PetApplication.create!(pet: bolt, application: smithers_application)

aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
bare_y = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: aurora.id)
babe = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: aurora.id)
elle = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: aurora.id)