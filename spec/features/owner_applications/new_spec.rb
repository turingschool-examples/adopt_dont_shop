require 'rails_helper'

RSPec.describe "New Application Page", type: :feature do
  describe "As a user, when I click on create new application" do
    it "shows a blank form to fill out" do
      visit "/applications/new"
      expect(page).to have_content('Name:')
      expect(page).to have_content('Street Address:')
      expect(page).to have_content('City:')
      expect(page).to have_content('State:')
      expect(page).to have_content('Zip Code:')
      expect(page).to have_button('Submit')
    end

    it "Shows an error if something isnt filled out and I click submit" do
      visit "/applications/new"
      fill_in 'Name:' with: 'Wyatt'
      click_button 'Submit'
      expect(page).to have_content('Please fill in all fields')
      expect(current_path).to eq('/applications/new')
      # expect(page).to have_content('Wyatt')
    end
  end
end
