# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

pawsnmo = Shelter.create!(foster_program: true, name: "Paws N Mo'", city: "Charlotte", rank: 4)
charlotte = Shelter.create!(foster_program: false, name: "Charlotte Foster Pets'", city: "Charlotte", rank: 6)
citycounty = Shelter.create!(foster_program: true, name: "City County", city: "New York City", rank: 2)
winthrop = Shelter.create!(foster_program: false, name: "Winthrop", city: "Winthrop", rank: 1)

pawsnmo.pets.create!(adoptable: true, age: 2, breed: "Border-Collie", name: "Jack")
pawsnmo.pets.create!(adoptable: true, age: 5, breed: "Boxer", name: "Charlie")
pawsnmo.pets.create!(adoptable: true, age: 3, breed: "Belgian Malinoise", name: "Cuddles")
pawsnmo.pets.create!(adoptable: false, age: 1, breed: "Pitbull", name: "Chocolate")

charlotte.pets.create!(adoptable: true, age: 1, breed: "German Shepherd", name: "Olive")
charlotte.pets.create!(adoptable: true, age: 4, breed: "Mix", name: "Cheddar")
charlotte.pets.create!(adoptable: false, age: 7, breed: "Pembrooke Corgi", name: "Dude")
charlotte.pets.create!(adoptable: true, age: 3, breed: "Cane Corso", name: "Penelope")

citycounty.pets.create!(adoptable: true, age: 1, breed: "Scottish Terrier", name: "Harry")
citycounty.pets.create!(adoptable: false, age: 6, breed: "Poodle", name: "Hermione")
citycounty.pets.create!(adoptable: true, age: 3, breed: "Rottweiler", name: "Rottie")
citycounty.pets.create!(adoptable: true, age: 2, breed: "French Bulldog", name: "Aus Jus")

winthrop.pets.create!(adoptable: true, age: 3, breed: "Siberian Husky", name: "Chilly")
winthrop.pets.create!(adoptable: true, age: 6, breed: "Labrador Retriever", name: "Fetch")
winthrop.pets.create!(adoptable: true, age: 3, breed: "Dachshund", name: "Frank")
winthrop.pets.create!(adoptable: true, age: 2, breed: "Mix", name: "Mel")

application1 = Application.create!(name: "Kon Ham", street_address: "5714 Carmel Rd", city: "Charlotte", state: "NC", zipcode: 28226, description: "I'm a cool guy")
application2 = Application.create!(name: "Gaelyn Cooper", street_address: "123 ABC St", city: "Huntsville", state: "AL", zipcode: 35649, description: "I'm a cool guy")
application3 = Application.create!(name: "Andrew Smith", street_address: "99 Bottles Rd", city: "Portland", state: "OR", zipcode: 97035, description: "I'm a cool guy")
application4 = Application.create!(name: "Leigh Pulzone", street_address: "52135 Mellow Blvd", city: "Bend", state: "OR", zipcode: 97701, description: "I'm a cool guy")
