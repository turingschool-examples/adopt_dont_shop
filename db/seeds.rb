# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

app = Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")

shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)

scooby = shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
sm_scooby = shelter.pets.create!(name: 'Scooby', age: 6, breed: 'Chihuahua', adoptable: true)
other_scooby = shelter.pets.create!(name: 'mr. scooby', age: 1, breed: 'Dalmation', adoptable: true)
scrappy = shelter.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true)
