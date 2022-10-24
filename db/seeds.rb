# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

app = Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")
kenz = Application.create!(name: "Kenz L", street_address: "318 E 3rd Ave", city: "Durango", state: "Colorado", zipcode: 81301, description: "Please let me adopt a pet!", status: "In Progress")
lauren = Application.create!(name: "Lauren D", street_address: "55 Mauldeth Drive", city: "Chattanooga", state: "Tennessee", zipcode: 37405, description: "I really need a pet or I will continue to be sad.", status: "In Progress")

mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
garden = Shelter.create!(name: 'Animal Garden', city: 'Okinawa City', foster_program: false, rank: 7)
friends = Shelter.create!(name: 'Dumb Friends League', city: 'Denver', foster_program: true, rank: 1)
bounce = Shelter.create!(name: 'Bounce Rescue', city: 'Aurora', foster_program: false, rank: 15)


scooby = mystery.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
sm_scooby = mystery.pets.create!(name: 'Scooby', age: 6, breed: 'Chihuahua', adoptable: true)
other_scooby = mystery.pets.create!(name: 'mr. scooby', age: 1, breed: 'Dalmation', adoptable: true)
scrappy = mystery.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true)
reba = friends.pets.create(name: 'Reba', age: 6, breed: 'Jack Russel Terrier mix', adoptable: true)
bird = friends.pets.create(name: 'Bird', age: 6, breed: 'Russian Blue', adoptable: true)
stinky = garden.pets.create(name: 'Stinky', age: 9, breed: 'Pit Bull', adoptable: true)
luna = garden.pets.create(name: 'Luna', age: 7, breed: 'German Shepard', adoptable: true)
pimento = bounce.pets.create(name: 'Pimento', age: 1, breed: 'Corgi', adoptable: true)
ruby = bounce.pets.create(name: 'Ruby', age: 2, breed: 'Blue Heeler', adoptable: true)
