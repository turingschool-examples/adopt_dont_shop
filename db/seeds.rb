# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Applicant.destroy_all

mike = Applicant.create!(
                      name: 'Mike Dao',
                      street_address: '245 Maple St',
                      city: 'Centennial',
                      state: 'Colorado',
                      zip_code: 80112,
                      applicant_bio: 'My dog needs another to chase up trees.',
                      application_status: 'Pending')

pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
pet = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
pet = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter.id)
pet = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)

shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
sheltshelter = Shelter.create!(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: true, rank: 7)
