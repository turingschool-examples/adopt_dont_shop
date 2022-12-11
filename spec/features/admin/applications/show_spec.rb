require 'rails_helper'

RSpec.describe "ADMIN Application Show" do
  describe "Story 12 - Approving a Pet for Adoption" do
    it "has a button next to EACH pet to approve adoption on application" do
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{___________.id}"
      # For every pet that the application is for, I see a button to approve the application for that specific pet
      expect(page).to have_content("#{________.name}")
      expect(page).to have_button("Approve")
      # When I click that button
      click_button("Approve")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq "/admin/applications/#{__________.id}"
      # And next to the pet that I approved, I do not see a button to approve this pet
      
      # And instead I see an indicator next to the pet that they have been approved
      
    end
  end
end