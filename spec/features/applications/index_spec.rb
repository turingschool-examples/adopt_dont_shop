require 'rails_helper'

RSpec.describe 'the applications index' do
  before :each do
    brighter_days = Shelter.create!(name: 'Brighter Days Shelter', rank: 1, city: 'Boulder', foster_program: true)
    underdogs = Shelter.create!(name: 'Underdogs Shelter', rank: 2, city: 'Denver', foster_program: true)

    bosco = brighter_days.pets.create!(name: 'Bosco', adoptable: true, age: 8, breed: 'Springer Spaniel')
    lily = brighter_days.pets.create!(name: 'Lily', adoptable: true, age: 5, breed: 'German Shepard Boxer Mix')

    izze = underdogs.pets.create!(name: 'Izze', adoptable: true, age: 8, breed: 'Cocker Spaniel')
    zephyr = underdogs.pets.create!(name: 'Zephyr', adoptable: true, age: 8, breed: 'Malamute')
    ruger = underdogs.pets.create!(name: 'Ruger', adoptable: true, age: 8, breed: 'Husky Samoyed Mix')

    app_1 = Application.create!(name: 'Elliot O.', street: '5743 Squirrel Circle', city: 'Aspen', state: 'CO', zip_code: 81611, application_status: 'pending')
    app_2 = Application.create!(name: 'Sami P.', street: '1123 Arbor Lane', city: 'Chicago', state: 'IL', zip_code: 60007, application_status: 'approved')
    app_3 = Application.create!(name: 'Amanda M.', street: '883 Teller Court', city: 'Wheat Ridge', state: 'CO', zip_code: 80033, application_status: 'pending')
    app_4 = Application.create!(name: 'Brian F.', street: '9090 Veterans Street', city: 'Wells', state: 'ME', zip_code: 14090, application_status: 'in progress')
    app_5 = Application.create!(name: 'Jacob M.', street: '8439 Felines Court', city: 'Westminster', state: 'CO', zip_code: 80021, application_status: 'rejected')
    app_6 = Application.create!(name: 'Jacob P.', street: '953 Brewers Street', city: 'Austin', state: 'TX', zip_code: 78704, application_status: 'pending')

    PetApplication.create!(pet: bosco, application: app_1)
    PetApplication.create!(pet: lily, application: app_1)
    PetApplication.create!(pet: izze, application: app_1)
    PetApplication.create!(pet: zephyr, application: app_1)
    PetApplication.create!(pet: ruger, application: app_1)
  end
end
