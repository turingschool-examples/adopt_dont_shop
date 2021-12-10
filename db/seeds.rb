# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 @shelter_1 = Shelter.create!(foster_program: true, name: "Aspen Grove", city: "Fort Collins", rank: 1)

 @application_1 = Application.create!(name: "John Napier", street_address: "936 Akin Ave.", city: "Fort Collins", state: "CO.", zip_code: 80521, description: "Good Owner", status: "Pending")
 
 @pet_1 = @application_1.pets.create!(adoptable: true, age: 1, breed: "Boston Terrier", name: "Zelma", shelter_id: @shelter_1.id)
 @pet_2 = @application_1.pets.create!(adoptable: true, age: 13, breed: "Tabby Cat", name: "Mazzy", shelter_id: @shelter_1.id)