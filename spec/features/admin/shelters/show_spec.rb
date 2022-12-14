require 'rails_helper'

RSpec.describe "Admin Shelters Show" do

  let!(:shelter) {create(:shelter)}
  let!(:another_shelter) {create(:shelter)}
  
  describe "User Story 19" do
    it 'shows name and full address on show page' do
      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content(shelter.name)
      expect(page).to have_content(shelter.city)
      expect(page).to_not have_content(another_shelter.name)
      expect(page).to_not have_content(another_shelter.city)
    end
  end    
end