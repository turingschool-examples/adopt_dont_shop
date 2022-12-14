require 'rails_helper'

RSpec.describe "Admin Shelters Show" do

  let!(:shelter) {create(:shelter)}
  let!(:another_shelter) {create(:shelter)}
  
  describe "User Story 19" do
    it 'shows name and full address on show page' do
      # Admin Shelters Show Page
      visit "/admin/shelters/#{shelter.id}"
      # As a visitor
      # When I visit an admin shelter show page
      # Then I see that shelter's name and full address
      expect(page).to have_content(shelter.name)
      expect(page).to have_content(shelter.city)
      expect(page).to_not have_content(another_shelter.name)
      expect(page).to_not have_content(another_shelter.city)
      # NOTE: Your query should only return the necessary data to complete the story
    end
  end    
end