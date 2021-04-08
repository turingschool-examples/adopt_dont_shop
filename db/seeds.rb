# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


application1 = OwnerApplication.create!(name: 'Wyatt Wicks', street_address: '559 s. washington st', city: 'Denver', state: 'Colorado', zip_code: 80209, description: 'Description goes here', status: 'In Progress')
shelter = Shelter.create!(foster_program: true, name: 'Pets 4 us', city: 'Denver', rank: 3)


pet1 = shelter.pets.create!(adoptable: true, age: 3, breed: 'Entlebucher', name: 'Josie')
