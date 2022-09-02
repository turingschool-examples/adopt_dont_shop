# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, status: "In Progress")
app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, status: "Pending")

shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Humane Society', city: 'Humboldt CA', foster_program: true, rank: 4)



pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: 'Fran', age: 4, breed: 'French Bulldog', adoptable: false, shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: 'Gilbert', age: 4, breed: 'Mutt', adoptable: true, shelter_id: shelter_2.id)