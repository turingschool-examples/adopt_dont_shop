# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all 

shelter_1 = Shelter.create!(name: 'Dumb Friends League', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Hollywood Shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
shelter_3 = Shelter.create!(name: 'EAPL', city: 'Evergreen, CO', foster_program: true, rank: 2)
shelter_4 = Shelter.create!(name: 'Arch City Adoptions', city: 'St. Louis, MO', foster_program: true, rank: 4)

pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson')
pet_2 = shelter_1.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie')
pet_3 = shelter_1.pets.create!(adoptable: true, age: 3, breed: 'Whippet', name: 'Annabelle')
pet_4 = shelter_2.pets.create!(adoptable: false, age: 8, breed: 'Lab', name: 'Trek')
pet_5 = shelter_2.pets.create!(adoptable: false, age: 6, breed: 'Cattle Dog', name: 'Otis')
pet_6 = shelter_3.pets.create!(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce')
pet_7 = shelter_3.pets.create!(adoptable: false, age: 5, breed: 'Pit', name: 'Vegas')
pet_8 = shelter_3.pets.create!(adoptable: true, age: 6, breed: 'Poodle', name: 'Oakley')
pet_9 = shelter_3.pets.create!(adoptable: true, age: 7, breed: 'Shiba Inu', name: 'Pepper')
pet_10 = shelter_4.pets.create!(adoptable: false, age: 8, breed: 'Chihuahua', name: 'Nacho')
pet_11 = shelter_4.pets.create!(adoptable: true, age: 9, breed: 'Dachsund', name: 'Busch')
pet_12 = shelter_4.pets.create!(adoptable: false, age: 2, breed: 'Corgi', name: 'Yoda')
pet_13 = shelter_4.pets.create!(adoptable: true, age: 1, breed: 'Border Collie', name: 'Louie')
pet_14 = shelter_4.pets.create!(adoptable: false, age: 4, breed: 'Terrier', name: 'Clark')
pet_15 = shelter_4.pets.create!(adoptable: true, age: 4, breed: 'Great Dane', name: 'Buff')
