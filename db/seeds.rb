# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all

@application_1 = Application.create!(name: 'Bob', street_address: '1234 Southeast St',
  city: 'San Francisco', state: 'CA', zip_code: 12345,
  description: 'Wants a dog', names_of_pets: 'Fluffy', application_status: 'Pending')

@application_2 = Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
  city: 'San Francisco', state: 'CA', zip_code: 54321,
  description: 'Would like a siamese cat', names_of_pets: 'Coz', application_status: 'In Progress')

@application_3 = Application.create!(name: 'Fred', street_address: '376 Monroe St',
  city: 'Los Angeles', state: 'CA', zip_code: 67890,
  description: 'Interested in sibling pets', names_of_pets: 'Jack, Jill', application_status: 'Accepted')

@application_4 = Application.create!(name: 'Jane', street_address: '74026 Deep South St',
  city: 'San Diego', state: 'CA', zip_code: 92056,
  description: 'Doesnt like animals', names_of_pets: 'Mittens', application_status: 'Rejected')