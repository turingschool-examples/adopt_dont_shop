require 'rails_helper'

RSpec.describe '/applications/:id', type: :feature do
  let!(:application_1) { Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals') }

  let!(:shelter) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

  let!(:bella) { shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) }
  let!(:rigby) { shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) }
  let!(:luna) { shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) }

  let!(:pet_app_1) { PetApplication.create!(pet: bella, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: rigby, application: application_1) }

  describe ' When I visit the applications show page' do
    it 'I can see all attributes of the application' do
      visit "/applications/#{application_1.id}" 

      expect(page).to have_content("Name: Taylor")
      expect(page).to have_content("Address: 123 Side St, Denver, CO 80202")
      expect(page).to have_content("Description: I love animals")
      expect(page).to have_content("Status: In Progress")

    end

    it 'I can see all pets that this application is for' do
      visit "/applications/#{application_1.id}" 
      expect(page).to have_content("Pets to apply for:")
      expect(page).to have_link("Bella")
      expect(page).to have_link("Rigby")
    end
  end
end