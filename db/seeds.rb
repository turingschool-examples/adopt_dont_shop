# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
app1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
                        city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs")
app2 = Applicant.create!(name: "Cydney Whitemon", street_address: "124 S Way Avenue",
                        city: "Denver", state: "CO", zip_code: "80019", description: "Dogs Like Me")
pet1 = Pet.create!(adoptable: true, age: 6, breed: "Catahoula Leopard Dog", name: "Rosy", shelter_id: shelter1.id)
pet2 = Pet.create!(adoptable: true, age: 4, breed: "Dobermann", name: "Lundy", shelter_id: shelter1.id)

pet_app1 = PetApplicant.create!(pet_id: pet1.id, applicant_id: app1.id)
pet_app2 = PetApplicant.create!(pet_id: pet2.id, applicant_id: app1.id)