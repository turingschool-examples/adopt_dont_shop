require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  describe 'When I visit the admin index page' do
    let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
    let!(:shelter_2) { Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9) }
    let!(:shelter_3) { Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9) }

    let!(:pet_2) { shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
    let!(:pet_3) { shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true) }

    let!(:application_1) { Application.create!(name: 'John Doe', address: '123 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals!') }
    let!(:application_2) { Application.create!(name: 'Jane Doe', address: '123 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals!') }

    it 'I see a all shelters in reverse alphabetical order' do

      visit '/admin/shelters'

      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(shelter_3.name)
      expect(page).to have_content(shelter_1.name)
    end

    it 'I see a section for shelters with pending applications' do
      visit '/admin/shelters'
  
      expect(page).to have_content("Shelters with Pending Applications")
    end

    it 'I see shelters with pending applications' do
      PetApplication.create!(pet: pet_2, application: application_1)
      PetApplication.create!(pet: pet_3, application: application_2)

      visit '/admin/shelters'

      expect(shelter_1.with_pending_applications).to eq("Aurora shelter")
    end
  end
end