require 'rails_helper'

RSpec.describe 'application creation' do
    it 'has a link to Start and Application' do
      visit "/pets"

      click_on "Start an Application"

      expect(current_path).to eq("/applications/new")
    end

    it 'takes me to a form to complete a new application' do # this could be nested in the other test?
      visit "/applications/new"

      fill_in(:name, with: "John Deere")
      fill_in(:street_address, with: "5678 Colorado Road")
      fill_in(:city, with: "Denver")
      fill_in(:state, with: "Colorado")
      fill_in(:zip, with: "80120")
      click_button "Submit"

      # expect(current_path).to eq("/applications/:id")
      expect(page).to have_content("John Deere")
      expect(page).to have_content("In Progress")
      expect(page).to_not have_content("Rejected")
      expect(page).to_not have_content("Pending")
      expect(page).to_not have_content("Accepted")
    end
end
