# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
PetApplication.destroy_all

@application1 = Application.create!(name: "Paul Leonard",
                                    address: "123 Smiley St.",
                                    city: "Atlanta",
                                    state: "Georgia",
                                    zip: "31768",
                                    description: "Single guy, 3 bedroom house on 7 acres. Lots of love to give!",
                                    status: "Pending")
@shelter1 = Shelter.create!(name: "Humane Society", rank: 8, city: "Atlanta")
@pet2     = @shelter1.pets.create!(name: "Mack", age: 3, shelter_id: @shelter1.id)
@pet_application2 = @application1.pet_applications.create!(pet_id: @pet2.id)
