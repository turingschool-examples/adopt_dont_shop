# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@shelter1 = Shelter.create!(name: 'Max Fund', city: 'Denver', foster_program: true, rank:4)
@shelter2 = Shelter.create!(name: 'Dumb Friends', city: 'Boulder', foster_program: true, rank:5)
@shelter3 = Shelter.create!(name: 'Animal Rescue', city: 'Fort Collins', foster_program: true, rank:4)

@pet1 = @shelter1.pets.create!(name: 'Francine', breed: 'dog', age: 1, adoptable: true)
@pet2 = @shelter2.pets.create!(name: 'Joey', breed: 'dog', age: 3, adoptable: true)
@pet3 = @shelter1.pets.create!(name: 'Mr. Dog', breed: 'cat', age: 10, adoptable: true)

@applicant1 = Application.create!(name: 'Brisa', address: '123 10th ave', city: 'Denver', state: 'CO', zip_code: 80205)
@applicant2 = Application.create!(name: 'Chris', address: '321 Blake st', city: 'Denver', state: 'CO', zip_code: 80204)
@applicant3 = Application.create!(name: 'Amber', address: '1000 Broadway st', city: 'Eerie', state: 'CO', zip_code: 80041)
@applicant4 = Application.create!(name: 'Levi', address: '1610 wewatta wy', city: 'Berthoud', state: 'CO', zip_code: 80491)

PetApplication.create!(pet: @pet1, application: @applicant1)
PetApplication.create!(pet: @pet1, application: @applicant2)
PetApplication.create!(pet: @pet2, application: @applicant1)
PetApplication.create!(pet: @pet2, application: @applicant2)
