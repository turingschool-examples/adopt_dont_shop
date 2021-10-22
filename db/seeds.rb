# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@shelter1 = Shelter.create!(
  name: 'Test Shelter',
  rank: 1,
  city: 'Denver'
)

@pet1 = @shelter1.pets.create!(
  name: 'Fluffy',
  age: 2,
)

@app1 = @pet1.applications.create!(
  name: 'CatMan',
  address: '123 Main Street',
  city: 'Denver',
  state: 'CO',
  zip: '80204',
  description: 'I WANT ALL THE CATS!'
)
