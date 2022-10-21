# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter.id)
    @shelter_2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'beagle mix', name: 'Josie', shelter_id: @shelter_2.id)
    @pet_5 = Pet.create(adoptable: true, age: 3, breed: 'chihuahua mix', name: 'Jojo', shelter_id: @shelter_2.id)
    @pet_6 = Pet.create(adoptable: true, age: 1, breed: 'domestic longhair', name: 'Mako', shelter_id: @shelter_2.id)
    @shelter3 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_7 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_8 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_8 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
    @app = AdoptApp.create!(name: "Amanda Ross",     
                                street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
    @app_2 = AdoptApp.create!(name: "Amanda Ross",     
                                  street_address: "1 S Broadway", 
                                  city: "White Plains", 
                                  state: "NY", 
                                  zip_code: "10603", 
                                  description: "Want companion.",
                                  status: "In Progress"
                                )