# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Pet.destroy_all
Application.destroy_all


application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")

northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
islandlake = Shelter.create!(foster_program: true, name: "Island Lake Animal Hopsital", city: "Denver", rank: 8)
banfield = Shelter.create!(foster_program: true, name: "Banfield Animal Hospital", city: "Orlando", rank: 9)

spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: northshore.id)
frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: northshore.id)
fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: northshore.id)
pancho = Pet.create!(adoptable: true, age: 5, breed: "Chiuahua", name: "Pancho", shelter_id: northshore.id)

spot_application = PetApplication.create!(application_id: application.id, pet_id: spot.id, status: application.status)
frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)
