require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do
  describe 'When I visit the admin index page' do
    let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
    let!(:shelter_2) { Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9) }
    let!(:shelter_3) { Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9) }

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
  end
end