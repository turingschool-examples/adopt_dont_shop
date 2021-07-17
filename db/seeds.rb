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

# shelters
brighter_days = Shelter.create!(name: 'Brighter Days Shelter', rank: 1, city: 'Boulder', foster_program: true)
underdogs = Shelter.create!(name: 'Underdogs Shelter', rank: 2, city: 'Denver', foster_program: true)

# pets
bosco = brighter_days.pets.create!(name: 'Bosco', adoptable: true, age: 8, breed: 'Springer Spaniel')
lily = brighter_days.pets.create!(name: 'Lily', adoptable: true, age: 5, breed: 'German Shepard Boxer Mix')
leia = brighter_days.pets.create!(name: 'Leia', adoptable: true, age: 6, breed: 'Bernadoodle')
beans = brighter_days.pets.create!(name: 'Beans', adoptable: true, age: 8, breed: 'German Shepard')

izze = underdogs.pets.create!(name: 'Izze', adoptable: true, age: 8, breed: 'Cocker Spaniel')
zephyr = underdogs.pets.create!(name: 'Zephyr', adoptable: true, age: 8, breed: 'Malamute')
ruger = underdogs.pets.create!(name: 'Ruger', adoptable: true, age: 8, breed: 'Husky Samoyed Mix')
clyde = underdogs.pets.create!(name: 'Clyde', adoptable: true, age: 8, breed: 'Boxer')
jasmine = underdogs.pets.create!(name: 'Jasmine', adoptable: true, age: 8, breed: 'Black Lab')
finn = underdogs.pets.create!(name: 'Finn', adoptable: true, age: 8, breed: 'Australian Shepard')

# applications
app_1 = Application.create!(name: 'Elliot', street: '5743 Squirrel Circle', city: 'Aspen', state: 'CO', zip_code: 81611, application_status: 'Pending')
app_2 = Application.create!(name: 'Sami', street: '1123 Arbor Lane', city: 'Chicago', state: 'IL', zip_code: 60007, application_status: 'Approved')
app_3 = Application.create!(name: 'Amanda', street: '883 Teller Court', city: 'Wheat Ridge', state: 'CO', zip_code: 80033, application_status: 'Pending')
app_4 = Application.create!(name: 'Brian', street: '9090 Veterans Street', city: 'Wells', state: 'ME', zip_code: 14090, application_status: 'In Progress')
app_5 = Application.create!(name: 'Jacob', street: '8439 Felines Court', city: 'Westminster', state: 'CO', zip_code: 80021, application_status: 'Rejected')
app_6 = Application.create!(name: 'Jacob', street: '953 Brewers Street', city: 'Austin', state: 'TX', zip_code: 78704, application_status: 'Pending')

# pet applications
PetApplication.create!(pet: bosco, application: app_1)
PetApplication.create!(pet: lily, application: app_1)
PetApplication.create!(pet: leia, application: app_1)
PetApplication.create!(pet: beans, application: app_1)
PetApplication.create!(pet: izze, application: app_1)
PetApplication.create!(pet: zephyr, application: app_1)
PetApplication.create!(pet: ruger, application: app_1)
PetApplication.create!(pet: clyde, application: app_1)
PetApplication.create!(pet: jasmine, application: app_1)
PetApplication.create!(pet: finn, application: app_1)
