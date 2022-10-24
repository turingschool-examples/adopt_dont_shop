# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
becky = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky", shelter: shelter_1)
bean = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Bean", shelter: shelter_1)
sam = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Sam", shelter: shelter_2)
application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
application_2 = Application.create!(name: "Test 2", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")

ApplicationPet.create!(pet: becky, application: application)
ApplicationPet.create!(pet: bean, application: application_2)
ApplicationPet.create!(pet: sam, application: application_2)
