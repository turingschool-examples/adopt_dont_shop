# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

@ddfl = Shelter.create!(name: "Denver Dumb Friends League", foster_program: true, city: "Denver", rank: 5)
@max = Shelter.create!(name: "Max Fund", foster_program: true, city: "Denver", rank: 5)

@doggo = @ddfl.pets.create!(adoptable: true, age: 12, breed: "Cairn Terrior", name: "Sylus")
@meow = @max.pets.create!(adoptable: true, age: 2, breed: "short hair", name: "Hopps")

# Creates a playlist

@bob = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554")
@bill = Application.create!(name: "Bill Nye", street_address: "1265 S Main St.", city: "Los Angeles", state: "CA", zip: "90006")

# Creates application and associates it with a pet. Under the hood, creates a row in the playlist_songs table

@oprah = @doggo.applications.create!(name: "Oprah", street_address: "12 Bellaire St.", city: "Los Angeles", state: "CA", zip: "90006")

# Creates song and associates it with a playlist. Under the hood, creates a row in the playlist_songs table

# @bird = @bob.pets.create!(adoptable: true, age: 6, breed: "Cockatoo", name: "Tweety", shelter: @ddfl)

 # Creates a row in the application_pets table. Associates an application with a pet

 # ApplicationPet.create!(pet: @moew, shelter: @max)
 # ApplicationPet.create!(pet: @doggo, shelter: @max)

# Creates a row in the playlist_songs table. Associates a playlist with a song
