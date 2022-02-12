# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

@application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I love dogs")
@application_2 = Application.create!(name: "Roman Reigns", street_address: "2354 Narwal ct", city: "Littleton", state: "CO", zipcode: "23785", description: "I'd love to have a new best friend")
@application_3 = Application.create!(name: "Denet Lament", street_address: "1987 Orange Tree st", city: "Lakewood", state: "CO", zipcode: "12343", description: "My dog needs a new friend")
@application_4 = Application.create!(name: "Riley Wiley", street_address: "8974 Witch blvd", city: "Lone Tree", state: "CO", zipcode: "98765", description: "I've always wanted a cat")
@application_5 = Application.create!(name: "Pabu Strong", street_address: "771 Ditch ave", city: "Frederick", state: "CO", zipcode: "80543", description: "I'd like a guard dog for my property.")
@application_6 = Application.create!(name: "Theresa Ann", street_address: "09092 Blossom st", city: "Huntington Beach", state: "CA", zipcode: "98765", description: "My dog passed away and I'm ready to love again.")
@application_7 = Application.create!(name: "Gretchen Grump", street_address: "67890 Bog st", city: "Castle Rock", state: "CO", zipcode: "98765", description: "None of your business")
@application_8 = Application.create!(name: "Harry Potter", street_address: "81274 Hogwarts ct", city: "Hogwarts", state: "KS", zipcode: "83754", description: "I would like a new owl")


dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
smart_friends_league = Shelter.create!(foster_program: true, name: "Smart Friends League", city: "Lakewood", rank: "2")

@mushu = @application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: dumb_friends_league )
@mantis = @application_1.pets.create!(adoptable: true, age: "2", breed: "cat", name:"Mantis", shelter: dumb_friends_league )
@tesla = @application_2.pets.create!(adoptable: false, age: "9", breed: "cat", name:"Tesla", shelter: dumb_friends_league )
@bowie = @application_2.pets.create!(adoptable: true, age: "1", breed: "dog", name:"Bowie", shelter: smart_friends_league )
@oreo = @application_3.pets.create!(adoptable: false, age: "13", breed: "dog", name:"Oreo", shelter: dumb_friends_league )
@rosco = @application_4.pets.create!(adoptable: true, age: "2", breed: "dog", name:"Rosco", shelter: smart_friends_league )
@diesel = @application_5.pets.create!(adoptable: false, age: "5", breed: "dog", name:"Diesel", shelter: dumb_friends_league )
@taquana = @application_6.pets.create!(adoptable: true, age: "9", breed: "cat", name:"Taquana", shelter: smart_friends_league )
@mary = @application_7.pets.create!(adoptable: true, age: "13", breed: "cat", name:"Mary", shelter: dumb_friends_league )
@leah = @application_7.pets.create!(adoptable: false, age: "5", breed: "horse", name:"Leah", shelter: dumb_friends_league )
@queen = @application_8.pets.create!(adoptable: true, age: "6", breed: "owl", name:"Queenie", shelter: smart_friends_league )