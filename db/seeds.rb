# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  smithers_application = Application.create!(name: 'Smithers', street_address: '4 Higgins',city: 'Springfield',state: 'IL',zip_code: 80085, description:'I have a lot of land and no friends',status: 'In Progress')
  shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9) 
  scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id) 
  pablo = Pet.create!(name: 'Pablo', age: 1, breed: 'Chihuahua', adoptable: true, shelter_id: shelter.id) 
  pet_app_1 = PetApplication.create!(pet: pablo, application: smithers_application) 
