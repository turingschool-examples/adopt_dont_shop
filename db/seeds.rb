# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
application1 = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
application2 = pet.applications.create!(name: 'John Smith', street: '123 N Central Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
pet1 = Pet.create(name: 'Scrappy', age: 3, breed: 'Mini Dane', adoptable: true, shelter_id: shelter.id)
pet2 = Pet.create(name: 'Scout', age: 2, breed: 'Terrier', adoptable: true, shelter_id: shelter.id)
pet3 = Pet.create(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
pet4 = Pet.create(name: 'Bailey', age: 6, breed: 'Golden Lab', adoptable: true, shelter_id: shelter.id)
pet5 = Pet.create(name: 'Wallace', age: 2, breed: 'Irish Bloodhound', adoptable: true, shelter_id: shelter.id)
pet6 = Pet.create(name: 'Jack', age: 2, breed: 'Jack Russel', adoptable: true, shelter_id: shelter.id)
pet7 = Pet.create(name: 'Toby', age: 2, breed: 'Shitsu', adoptable: true, shelter_id: shelter.id)
pet8 = Pet.create(name: 'Oscar', age: 2, breed: 'Weiner dog', adoptable: true, shelter_id: shelter.id)
pet9 = Pet.create(name: 'Velma', age: 2, breed: 'Chihuahua', adoptable: true, shelter_id: shelter.id)
application1.pets << pet1
