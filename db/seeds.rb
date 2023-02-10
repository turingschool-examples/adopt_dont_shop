# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)

@snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')

@huy = Application.create!(applicant_name: "Huy Phan", app_street: "123 Park Ave", app_city: "Denver", app_state: "CO", app_zip_code: "80205", description: "Im super cool and stuffy" )

ApplicationPet.create!(pet: @snugglez, application: @huy)