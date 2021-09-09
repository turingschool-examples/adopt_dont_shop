# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

@application1 = Application.create!(name: 'Murph', street: '123 Apple St', city: 'Boca Raton', state: 'FL', zip: 33498, description: 'I want Jack', status: 'in progress')
@application2 = Application.create!(name: 'Derek', street: '345 Orange Ave', city: 'Fort Collins', state: 'CO', zip: 80521, description: 'I have lots of frisbees', status: 'in progress')
@application3 = Application.create!(name: 'Weirdo', street: '567 Banana Rd', city: 'Berthoud', state: 'CO', zip: 80517, description: 'I am hungry', status: 'rejected')

@shelter1 = Shelter.create!(name: 'Pups and Suds', city: 'Fort Collins', foster_program: false, rank: 2)
@shelter2 = Shelter.create!(name: 'Hounds in Pounds', city: 'Loveland', foster_program: true, rank: 5)
@shelter3 = Shelter.create!(name: 'Cats Suck', city: 'Brighton', foster_program: false, rank: 9)

@pet1 = @shelter1.pets.create!(name: 'Jack', age: 4, breed: 'Australian Shepherd', adoptable: true)
@pet2 = @shelter1.pets.create!(name: 'Cooper', age: 3, breed: 'Golden Retriever', adoptable: true)
@pet3 = @shelter2.pets.create!(name: 'Sampson', age: 2, breed: 'Great Pyrenese', adoptable: true)
@pet4 = @shelter3.pets.create!(name: 'Charlie', age: 13, breed: 'Lab Mix', adoptable: true)
