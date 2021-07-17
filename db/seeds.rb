# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all
PetApplication.destroy_all
Application.destroy_all

brighter_days = Shelter.create!(name: 'Brighter Days Shelter', rank: 1, city: 'boulder', foster_program: true)
underdogs = Shelter.create!(name: 'Underdogs Shelter', rank: 2, city: 'denver', foster_program: true)

bosco = brighter_days.pets.create!(name: 'Bosco', adoptable: true, age: 8, breed: 'Springer Spaniel')
lily = brighter_days.pets.create!(name: 'Lily', adoptable: true, age: 5, breed: 'German Shepard Boxer Mix')
leia = brighter_days.pets.create!(name: 'Leia', adoptable: true, age: 6, breed: 'Bernadoodle')
toby = brighter_days.pets.create!(name: 'Toby', adoptable: true, age: 3, breed: 'Chocolate Lab')
beans = brighter_days.pets.create!(name: 'Beans', adoptable: true, age: 8, breed: 'German Shepard')

izze = underdogs.pets.create!(name: 'Izze', adoptable: true, age: 8, breed: 'Cocker Spaniel')
zephyr = underdogs.pets.create!(name: 'Zephyr', adoptable: true, age: 8, breed: 'Malamute')
ruger = underdogs.pets.create!(name: 'Ruger', adoptable: true, age: 8, breed: 'Husky Samoyed Mix')
clyde = underdogs.pets.create!(name: 'Clyde', adoptable: true, age: 8, breed: 'Boxer')
jasmine = underdogs.pets.create!(name: 'Jasmine', adoptable: true, age: 8, breed: 'Black Lab')
finn = underdogs.pets.create!(name: 'Finn', adoptable: true, age: 8, breed: 'Australian Shepard')

app_1 = Application.create!(name: 'Elliot Olbright', street: '5743 Squirrel Circle', city: 'Aspen', state: 'CO', zip_code: 81611, application_status: 'pending')
app_2 = Application.create!(name: 'Sami Peterson', street: '1123 Arbor Lane', city: 'Chicago', state: 'IL', zip_code: 60007, application_status: 'approved')
app_3 = Application.create!(name: 'Amanda McGuire', street: '883 Teller Court', city: 'Wheat Ridge', state: 'CO', zip_code: 80033, application_status: 'pending')
app_4 = Application.create!(name: 'Brian Fletcher', street: '9090 Veterans Street', city: 'Wells', state: 'ME', zip_code: 14090, application_status: 'in progress')
app_5 = Application.create!(name: 'Jacob Martinez', street: '8439 Felines Court', city: 'Westminster', state: 'CO', zip_code: 80021, application_status: 'rejected')
app_6 = Application.create!(name: 'Jacob Piland', street: '953 Brewers Street', city: 'Austin', state: 'TX', zip_code: 78704, application_status: 'pending')

PetApplication.create!(pet: bosco, application: app_1)
PetApplication.create!(pet: lily, application: app_1)
PetApplication.create!(pet: leia, application: app_1)
PetApplication.create!(pet: toby, application: app_1)
PetApplication.create!(pet: beans, application: app_1)
PetApplication.create!(pet: izze, application: app_1)
PetApplication.create!(pet: zephyr, application: app_1)
PetApplication.create!(pet: ruger, application: app_1)
PetApplication.create!(pet: clyde, application: app_1)
PetApplication.create!(pet: jasmine, application: app_1)
PetApplication.create!(pet: finn, application: app_1)
