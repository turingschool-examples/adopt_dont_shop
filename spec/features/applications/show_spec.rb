require 'rails_helper'

RSpec.describe 'application show page' do

  it 'displays applicant: name, address(street, city, state, zip), description and status ' do

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    application_1 = Application.create!(name:'Alice', street: '357 test st', city: 'Frederickburg', state: 'VA', zip: '22406')
    PetApplication.create!(pet: pet_1, application: application_1)

    visit "/applications/#{application_1.id}"
    within("#application-#{application_1.id}") do
      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.street)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zip)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.status)
      expect(page).to have_content(pet_1.name)
    end
  end

  it "pet names are links to that pet's id page" do

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    application_1 = Application.create!(name:'Alice', street: '357 test st', city: 'Frederickburg', state: 'VA', zip: '22406')
    PetApplication.create!(pet: pet_1, application: application_1)

    visit "/applications/#{application_1.id}"
    within("#application-#{application_1.id}") do
      click_link "#{pet_1.name}"
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end
  end
end
