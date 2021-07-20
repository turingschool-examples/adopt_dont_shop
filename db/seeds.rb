# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all

#applications
@app1 = Application.create(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, status: 'pending')
@app2 = Application.create(name: 'Bette Porter', street: '777 Corona St', city: 'Denver', state: 'CO', zip_code: 80221, status: 'pending')
@app3 = Application.create(name: 'Shane McCutchen', street: '1234 Pine Ave', city: 'Arvada', state: 'CO', zip_code: 80218, status: 'approved')
@app4 = Application.create(name: 'Jenny Schecter', street: '2043 21st St', city: 'Denver', state: 'CO', zip_code: 80218, status: 'rejected')
@app5 = Application.create(name: 'Tina Kennard', street: '12 Colorado Blvd', city: 'Denver', state: 'CO', zip_code: 80210, status: 'rejected')
@app6 = Application.create(name: 'Dana Fairbanks', street: '646 Savannah St', city: 'Fort Collins', state: 'CO', zip_code: 89342, status: 'approved')
@app7 = Application.create(name: 'Tasha Williams', street: '213 Federal Blvd', city: 'Denver', state: 'CO', zip_code: 80304, status: 'pending')
@app8 = Application.create(name: 'Kit Porter', street: '1235 Maple St', city: 'Boulder', state: 'CO', zip_code: 80301, status: 'approved')
@app9 = Application.create(name: 'Jodi Lerner', street: '999 Best Ave', city: 'Broomfield', state: 'CO', zip_code: 80031, status: 'pending')
@app10 = Application.create(name: 'Helena Peabody', street: '6898 Pennsylvania Ave', city: 'Boulder', state: 'CO', zip_code: 81129, status: 'rejected')

#shelters
@shelter_1 = Shelter.create(name: "Boulder Humane Society", city: "Boulder, CO", rank: 1, foster_program: true)
@shelter_2 = Shelter.create(name: "Denver Humane Society", city: "Denver, CO", rank: 2, foster_program: false)

#pets
@pet1 = @shelter_1.pets.create(name: "Gertie", breed: "Border Collie", adoptable: true, age: 1)
@pet2 = @shelter_1.pets.create(name: "Millie", breed: "Labrador Retriever", adoptable: true, age: 3)
@pet3 = @shelter_1.pets.create(name: "Harper", breed: "Lab/Shar Pei/Chow mix", adoptable: false, age: 1)
@pet4 = @shelter_1.pets.create(name: "Rock", breed: "Pit Pull", adoptable: true, age: 4)
@pet5 = @shelter_2.pets.create(name: "Pebble", breed: "Chihuahua", adoptable: true, age: 2)
@pet6 = @shelter_2.pets.create(name: "Brandy", breed: "Chocolate Lab", adoptable: true, age: 8)
@pet7 = @shelter_2.pets.create(name: "Lady", breed: "German Shepherd", adoptable: true, age: 1)
@pet8 = @shelter_2.pets.create(name: "Scooby", breed: "Great Dane", adoptable: false, age: 5)
