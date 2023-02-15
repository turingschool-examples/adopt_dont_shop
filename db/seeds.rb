Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@app = Application.create!(name: 'John Smith',
                           address: '123 Fake Street',
                           city: 'Springfield',
                           state: 'IL',
                           zipcode: 12345,
                           description: 'I like dogs.',
                           status: 'In Progress')

shelter = Shelter.create!(
  foster_program: true,
  name: 'Dog house',
  city: 'Springfield',
  rank: 1
)
fido = shelter.pets.create!(
  adoptable: true,
  age: 1,
  breed: 'weiner',
  name: 'Fido'
)
santa = shelter.pets.create!(
  adoptable: true,
  age: 1,
  breed: 'whippet',
  name: 'Santa\'s Little Helper'
)
