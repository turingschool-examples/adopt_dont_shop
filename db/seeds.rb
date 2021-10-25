# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# shelters
shelter1 = Shelter.create!(foster_program: true,
                           name: 'Rocky Mountain Dog Shelter',
                           city: 'Denver',
                           rank: 1)
shelter2 = Shelter.create!(foster_program: true,
                           name: 'Denver Dog Shelter',
                           city: 'Denver',
                           rank: 2)                           
shelter3 = Shelter.create!(foster_program: false,
                           name: 'Colorado Springs Dog Rescue',
                           city: 'Colorado Springs',
                           rank: 3)  

# pets 
pet1 = shelter1.pets.create!(adoptable: true,
                   age: 3,
                   breed: "Labrador Retriever",
                   name: 'Bailey')
pet2 = shelter1.pets.create!(adoptable: true,
                   age: 1,
                   breed: "French Bulldog",
                   name: 'Bella')
pet3 = shelter1.pets.create!(adoptable: false,
                   age: 4,
                   breed: "German Shepard",
                   name: 'Max')
pet4 = shelter2.pets.create!(adoptable: true,
                   age: 6,
                   breed: "Golden Retriever",
                   name: 'Molly')
pet5 = shelter2.pets.create!(adoptable: true,
                   age: 8,
                   breed: "Bulldog",
                   name: 'Charlie')
pet6 = shelter2.pets.create!(adoptable: false,
                   age: 2,
                   breed: "Poodle",
                   name: 'Lucy')
pet7 = shelter3.pets.create!(adoptable: true,
                   age: 1,
                   breed: "Beagle",
                   name: 'Buddy')
pet8 = shelter3.pets.create!(adoptable: true,
                   age: 5,
                   breed: "Rottweiler",
                   name: 'Daisy')
pet9 = shelter3.pets.create!(adoptable: false,
                   age: 2,
                   breed: "German Shorthaired Pointer",
                   name: 'Rocky')

# applications
application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                   street_address: '123 Main Street', 
                                   city: 'Denver', 
                                   state: 'CO',
                                   zipcode: '80223',
                                   application_status: 'Pending',
                                   why: 'I love dogs')
application2 = Application.create!(applicant_name: 'Joe Smith', 
                                   street_address: '456 North Street', 
                                   city: 'Denver', 
                                   state: 'CO',
                                   zipcode: '80202',
                                   application_status: 'Pending',
                                   why: 'I currently have two other dogs')

# Create ApplicationPets associations
application1.pets << pet1
application1.pets << pet2
application2.pets << pet4
application2.pets << pet5