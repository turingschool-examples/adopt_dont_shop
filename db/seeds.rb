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

@shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
@shelter_3 = Shelter.create!(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
@shelter_4 = Shelter.create!(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: true, rank: 7)

@pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
@pet_3 = Pet.create!(adoptable: true, age: 2, breed: 'Great Dane', name: 'Scooby', shelter_id: @shelter_3.id)    
@pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: @shelter_4.id)
@pet_5 = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: @shelter_3.id)
@pet_6 = Pet.create!(adoptable: false, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: @shelter_1.id)

@applicant_1 = Application.create!(name: 'Jasmine', street_address: '1011 P St.', city: 'Las Vegas', state: 'Nevada', zip_code: '89178', description: "I'm lonely.", status: 'In Progress')
@applicant_2 = Application.create!(name: 'Elle', street_address: '2023 Something St.', city: 'Denver', state: 'Colorado', zip_code: '80014', description: "I love animals!", status: 'Pending')
