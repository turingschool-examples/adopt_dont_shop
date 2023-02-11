# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@applicant_1 = Application.create(name: 'Rumiko Takahashi', address: '4307 Saddle Creek Place', city: "Orlando", state: "Florida", zip_code: 32829, status: 0, description: 'Single and has great income, flexible schedule for pet needs.')

@shelter1= Shelter.create(name: "Caring Dogs", foster_program: true, city: "Puerto escondido", rank: 1)

@pet1 = Pet.create(adoptable: true, age: 23, breed: "Golden", name: "Norma Jean", shelter_id: @shelter1.id)