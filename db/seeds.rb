# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter_1 = Shelter.create!(foster_program: false, name: "The Farm", city: "Denver", rank: 2)
pet_1 = Pet.create!(adoptable: true, age: 1, breed: "Great Dane", shelter_id: 1, name: 'Scooby', )
app_1 = Form.create!(name: "John Smith", street_address: "123 Main St.", city: "Denver", state: "CO", zip_code: 80202, description:"I want a pet.", status: "Accepted")