# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter1 = Shelter.create!(foster_program: true, name: "Moms and Mutts", city: "Denver", rank:1)
@shelter2 = Shelter.create!(foster_program: false, name: "Pet Supermarket", city: "Plano", rank:999)
@shelter3 = Shelter.create!(foster_program: false, name: "A Safe Haven", city: "Miami", rank:250)

@pet1 = @shelter1.pets.create!(adoptable: true, age:3, breed:"Pitbull", name:"Scrappy")
@pet2 = @shelter1.pets.create!(adoptable: true, age:5, breed:"German Shepherd", name:"Gossamer")
@pet3 = @shelter1.pets.create!(adoptable: false, age:1, breed:"Lab Mix", name:"Montana")
@pet4 = @shelter1.pets.create!(adoptable: true, age:2, breed:"Golden Retreiver", name:"Gus")
@pet5 = @shelter2.pets.create!(adoptable: true, age:2, breed:"French Bulldog", name:"Bella")
@pet6 = @shelter2.pets.create!(adoptable: false, age:1, breed:"Tabby", name:"Nugget")

@application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", description:"I love dogs and would be such a good dog mom", status: "In Progress")
@application2 = Application.create!(name:"Dominic OD", street_address:"5250 Town and Country Blvd.", city:"Frisco", state:"Texas", zipcode:"75034", description:"I like cats.", status: "In Progress")
@application3 = Application.create!(name:"Carla Whipkey", street_address:"4801 Dargate Lane", city:"Murrysville", state:"PA", zipcode:"15668", description:"I want to adopt all the dogs", status: "In Progress")
@application4 = Application.create!(name:"Corey Whitehall", street_address:"1234 Oak Lane", city:"Nichols", state:"Iowa", zipcode:"12345", description:"Pets are cool", status: "In Progress")

PetApplication.create!(pet: @pet1, application: @application1)
PetApplication.create!(pet: @pet2, application: @application1)
PetApplication.create!(pet: @pet1, application: @application2)
PetApplication.create!(pet: @pet3, application: @application3)
PetApplication.create!(pet: @pet3, application: @application4)
PetApplication.create!(pet: @pet4, application: @application4)
PetApplication.create!(pet: @pet5, application: @application4)
PetApplication.create!(pet: @pet4, application: @application3)
