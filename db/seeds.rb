# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Pet.destroy_all

shelter_1 = Shelter.create(
  name: 'Foothills Animal Shelter',
  city: "Lakewood",
  foster_program: false,
  rank: 9
      )

shelter_2 = Shelter.create(
  name: "Dumb Friends League",
  city: "Aurora",
  foster_program: true,
  rank: 7
  )

shelter_3 = Shelter.create(
  name: "Max Fund",
  city: "Denver",
  foster_program: true,
  rank: 3
  )

pet_1 = Pet.create(
  adoptable: true,
  age: 1,
  breed: 'sphynx',
  name: 'Lucille Bald',
  shelter_id: shelter_1.id)

pet_2 = Pet.create(
  adoptable: true,
  age: 6,
  breed: 'doberman',
  name: 'Lobster',
  shelter_id: shelter_1.id)

pet_3 = Pet.create(
  adoptable: true,
  age: 7,
  breed: 'husky',
  name: 'Sarge',
  shelter_id: shelter_1.id)

pet_4 = Pet.create(
  adoptable: true,
  age: 3,
  breed: 'yellow lab',
  name: 'Mandy',
  shelter_id: shelter_2.id)

pet_5 = Pet.create(
  adoptable: true,
  age: 10,
  breed: 'russian blue',
  name: 'Burt',
  shelter_id: shelter_2.id)

pet_6 = Pet.create(
  adoptable: true,
  age: 3,
  breed: 'rottweiler',
  name: 'Dana',
  shelter_id: shelter_2.id)

pet_7 = Pet.create(
  adoptable: true,
  age: 5,
  breed: 'black lab',
  name: 'Charlie',
  shelter_id: shelter_3.id)

pet_8 = Pet.create(
  adoptable: true,
  age: 2,
  breed: 'orange tabby',
  name: 'Taco',
  shelter_id: shelter_3.id)

pet_9 = Pet.create(
  adoptable: true,
  age: 1,
  breed: 'manx',
  name: 'Stubbs',
  shelter_id: shelter_3.id)
