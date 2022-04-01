# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
Shelter.destroy_all
Pet.destroy_all

application = Application.create!(name: "James",
                                  address: "1259 N Clarkson St.",
                                  city: "Denver",
                                  state: "CO",
                                  zipcode: "80218",
                                  description: "Love dogs",
                                  status: "In-progress")
shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
pet_1 = application.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
pet_2 = application.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
pet_3 = Pet.create(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
