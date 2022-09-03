# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@shelter1 = Shelter.create!(foster_program: "true", name:"Furry Friends", city: "Denver", rank:"3")
@cookie = @shelter1.pets.create!(adoptable: "true", name: "Cookie", breed:"chihuahua", age:"5")
@spot = @shelter1.pets.create!(adoptable: "true", name: "Spot", breed:"dalmation", age:"2")
@dash = @shelter1.pets.create!(adoptable: "false", name: "Dash", breed:"golden retriever", age:"13")

@john_doe_app = Application.create!(name: 'John Doe', street_address: '656 Main St.', city: 'Birmingham', state: 'AL', zip_code: 85267, description: "I've been a dog trainer for 40 years and I spend most of my days at home.", status: 'Pending')
@jane_johnson_app = Application.create!(name: 'Jane Johnson', street_address: '2548 Bungalow Ave', city: 'Spokane', state: 'WA', zip_code: 27338, status: 'In Progress')
@roberta_benson_app = Application.create!(name: 'Roberta Benson', street_address: '700 W 18th Ave Apt 101', city: 'Bend', state: 'OR', zip_code: 84585, description: 'I am very responsible and need animal friends because I have no human friends.', status: 'Pending')

@john_doe_app.pets << [@cookie, @spot]
# @jane_johnson_app.pets << [@dash]
@roberta_benson_app.pets << [@cookie, @dash, @spot]