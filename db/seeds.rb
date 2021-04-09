# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

OwnerApplication.destroy_all
Shelter.destroy_all
Pet.destroy_all
application1 = OwnerApplication.create!(name: 'Dog Man', street_address: 'Pet City', city: 'Denver', state: 'Colorado', zip_code: 80209, description: 'I like dogs and they like me', status: 'In Progress')
application2 = OwnerApplication.create!(name: 'Hank Hill', street_address: '324 Slow City', city: 'Arlington', state: 'Texas', zip_code: 90612, description: "That boy ain't right and he needs a dog", status: 'In Progress')
shelter = Shelter.create!(foster_program: true, name: 'Pets 4 us', city: 'Denver', rank: 3)


pet1 = shelter.pets.create!(adoptable: true, age: 2, breed: 'Entlebucher', name: 'Josie')
pet2 = shelter.pets.create!(adoptable: true, age: 12, breed: 'Brussels Griphon', name: 'Bella')
pet3 = shelter.pets.create!(adoptable: true, age: 20, breed: 'Miniature Italian GreyHound', name: 'Pica')
pet3 = shelter.pets.create!(adoptable: true, age: 16, breed: 'Miniature Italian GreyHound', name: 'Mojo')
pet3 = shelter.pets.create!(adoptable: true, age: 5, breed: 'Dalmatian', name: 'Spot')
