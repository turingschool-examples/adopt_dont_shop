# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@no_dog_left_behind = Shelter.create!(name: 'No Dog Left Behind', rank: 1, foster_program: true, city: 'Dallas')
@homeward_bound = Shelter.create!(name: 'Homeward Bound', rank: 2, foster_program: true, city: 'Dallas')
@lady = @no_dog_left_behind.pets.create!(name: "Lady", age: 3, breed: 'Ridgeback', adoptable: true)
@jax = @no_dog_left_behind.pets.create!(name: "Jax", age: 1, breed: 'Golden Retriever', adoptable: true)
@boss = @no_dog_left_behind.pets.create!(name: "Boss", age: 2, breed: 'German Shepard', adoptable: true)
@luke = @homeward_bound.pets.create!(name: "Luke", age: 1, breed: 'Huskie', adoptable: true)
@milka = @homeward_bound.pets.create!(name: "Milka", age: 2, breed: 'English Retriever', adoptable: true)
@ducky = @homeward_bound.pets.create!(name: "Ducky", age: 5, breed: 'Unkown', adoptable: true)
