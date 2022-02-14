# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
application_1 = Application.create!(name: "Austin Moore", street_address: "9999 Imaginary Ave", city: "Laurel", state: "MD", zip_code: "99999", description: "I am very nice", full_address: "9999 Imaginary Ave, Laurel, MD 99999", status: :in_progress)
shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)
pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter_2.id)
pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: shelter_1.id)
pet_application_1 = PetApplication.create!(pet: pet_1, application: application_1, approved: true)
pet_application_2 = PetApplication.create!(pet: pet_2, application: application_1, approved: true)
