# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

# vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
# vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office.id)
# vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)

shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

# shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
# shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
# shelter.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)


# application = Application.create!(name: 'Debbie Yang', street_address: '1234 dog way', city: "San Francisco", state: 'CA', zip_code: 66012)

pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter_2.id)
pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter_3.id)

# pet_4 = shelter.pets.create!(adoptable: true, age: 3, breed: 'Yorkie', name: 'Pickle')
# pet_5 = shelter.pets.create!(adoptable: true, age: 5, breed: 'German Shephard', name: 'Pickles')

app_1 = pet_1.applications.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending")
app_2 = pet_2.applications.create(name: "Violet", street_address: "678 Main st", city: "Denver", state: "CO", zip_code: "83302", application_status: "In Progress")
app_3 = pet_3.applications.create(name: "Hannah", street_address: "MLK blvd", city: "Denver", state: "CO", zip_code: "83402", application_status: "Pending")