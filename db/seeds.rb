# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

@simba = @shelter_1.pets.create(name: 'simba', age:12, breed: 'Doberman', adoptable: true)
@terry = @shelter_1.pets.create(name: 'Terry', age:3, breed: 'Hot Dog', adoptable: true)
@goofy = @shelter_2.pets.create(name: 'Goofy', age:10, breed: 'Mut', adoptable: true)
@rayo = @shelter_2.pets.create(name: 'Rayo', age:9, breed: 'Great Dane', adoptable: true)
@scooby = @shelter_3.pets.create(name: 'Scooby', age:8, breed: 'Poodle', adoptable: true)
@patatus = @shelter_3.pets.create(name: 'Patatus', age:2, breed: 'Lab', adoptable: true)

@application_1 = Application.create(name: "Jose Molina", street_address: "345 Colfax Ave", city: "Denver", state: "CO", zip_code: "80203", description: "I want a cat")
@application_2 = Application.create(name: "Rodrigo Rosales", street_address: "6723 Knot St", city: "Denver", state: "CO", zip_code: "80202", description: "I want a dog")
@application_3 = Application.create(name: "Horacio Quinteros", street_address: "9856 Fraizer Ave", city: "Boulder", state: "CO", zip_code: "80201", description: "I love animals")
