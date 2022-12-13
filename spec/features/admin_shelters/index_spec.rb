require 'rails_helper'
require 'test_helper'

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name

RSpec.describe "Admin Shelters Index" do
  describe "User Story 10" do
    it 'shows all Shelters listed in reverse alphabetical order' do
      seed_shelters
      visit '/admin/shelters'
      
      expect("Ruff Day").to appear_before("Healthy Paws")
      expect("Healthy Paws").to appear_before("AAA Shelter")
    end
  end
  
  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application

  describe "User Story 11" do
    it 'has a section for shelters with pending applications' do
      seed_shelters
      seed_applications

      visit '/admin/shelters'

      expect(page).to have_content("Shelters with Pending Applications")
    end

    it 'will show the name of every shelter that has pending applications' do
      seed_shelters
      seed_applications
      seed_pets
      seed_application_pets
  
      visit '/admin/shelters'

      within("#pending_pets") do 
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
      end

      expect(current_path).to eq('/admin/shelters')
    end
  end
end