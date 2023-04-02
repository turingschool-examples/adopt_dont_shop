require 'rails_helper'

RSpec.describe '/admin/application/:id', type: :feature do
  let!(:application_1) { Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 1) }
  let!(:application_2) { Application.create!(name: 'Thomas', address: '456 Main St', city: 'Denver', state: 'CO', zip: '80123', description: 'I hate animals') }
  
  let!(:shelter) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

  let!(:bella) { shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) }
  let!(:rigby) { shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) }
  let!(:luna) { shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) }

  let!(:pet_app_1) { PetApplication.create!(pet: bella, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: rigby, application: application_1) }

  describe 'When I visit the admin applications show page' do
    it 'I see every pet that the application is for' do
      visit "/admin/applications/#{application_1.id}"
      expect(page).to have_content('Application Status: Pending')
      expect(page).to have_content('Bella')
      expect(page).to have_content('Rigby')
    end

    it 'I see a button next to each pet to approve the application for that pet' do
      visit "/admin/applications/#{application_1.id}"

      expect(page).to have_button('Approve Bella')
      expect(page).to have_button('Approve Rigby')
    end
  end
end