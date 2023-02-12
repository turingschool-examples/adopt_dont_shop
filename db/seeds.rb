# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# @application = Petition.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
# state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'Pending')

@john = Petition.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
                    state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'Pending')
@bill = Petition.create!(name: 'Bill', street_address: '2 Sesame St', city: 'Nedver',
                    state: 'CA', zip_code: 89876, description: '', status: 'In Progress')                    
# @petition2 = Petition.create!(name: 'Nhoj', street_address: '2 Sesame St', city: 'Renved',
#                     state: 'OC', zip_code: 54321, description: 'Dogs like I', status: 'Pending')
@shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
@shelter1 = Shelter.create(name: 'Ystery Building', city: 'Irvine CA', foster_program: false, rank: 4)
@pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
# @pet2 = Pet.create!(name: 'Dooby', age: 3, breed: 'Greater Dane', adoptable: true, shelter_id: @shelter.id, petition_id: @petition.id)
# @pet3 = Pet.create!(name: 'Roo', age: 5, breed: 'Greatest Dane', adoptable: true, shelter_id: @shelter.id, petition_id: @petition2.id)
@petition_pet = PetitionPet.create!(petition_id: @john.id, pet_id: @pet1.id)