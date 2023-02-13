# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

@pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
@humaine = Shelter.create!(foster_program: true, name: 'Humaine Society', city: "Boulder", rank: 1)

@snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')
@squeaks = @pound.pets.create!(adoptable: true, age: 3, breed: "Cat", name: 'Squeaks')
@buster = @humaine.pets.create!(adoptable: true, age: 7, breed: "Doberman", name: 'Buster')
@meko = @humaine.pets.create!(adoptable: true, age: 4, breed: "Pit Bull", name: 'Meko')

@huy = Application.create!(applicant_name: "Huy Phan", app_street: "123 Park Ave", app_city: "Denver", app_state: "CO", app_zip_code: "80205", description: "Im super cool and stuff" )
@tori = Application.create!(applicant_name: "Tori", app_street: "345 Main St", app_city: "Denver", app_state: "CO", app_zip_code: "80206", description: "I lyke pets and treat them nice")
@khoa = Application.create!(applicant_name: "Khoa", app_street: "Somewhere St", app_city: "Littleton", app_state: "CO", app_zip_code: "80121", description: "I am the best, duh" )
@axel = Application.create!(applicant_name: "Axel", app_street: "959 Broadway", app_city: "Louisville", app_state: "CO", app_zip_code: "80423", description: "I can grow plants, why not raise pets" )
