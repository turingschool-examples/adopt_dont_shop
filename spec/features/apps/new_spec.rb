require 'rails_helper'

RSpec. describe 'New Application' do
  describe 'When I visit new application page' do
    it 'I can see an application form' do
      visit '/apps/new'

      expect(page).to have_content("Name")
      expect(page).to have_field("name")
      expect(page).to have_content("Street address")
      expect(page).to have_field("street_address")
      expect(page).to have_content("City")
      expect(page).to have_field("city")
      expect(page).to have_content("State")
      expect(page).to have_field("state")
      expect(page).to have_content("Zip code")
      expect(page).to have_field("zip_code")
      expect(page).to have_content("Description")
      expect(page).to have_field("description")
      expect(page).to have_button("Submit")
    end

    it 'I can fill out the form and submit' do
      visit '/apps/new'

      fill_in "name", with: "John Travolta"
      fill_in "street_address", with: "1234 Lamy"
      fill_in "city", with: "Denver"
      fill_in "state", with: "Colorado"
      fill_in "zip_code", with: "80906"
      fill_in "description", with: "I like dogs. Give me a dog"

      click_button "Submit"
      # expect(current_path).to be("/apps/#{app.id}")
      expect(page).to have_content("Name: John Travolta")
      expect(page).to have_content("Street address: 1234 Lamy")
      expect(page).to have_content("City: Denver")
      expect(page).to have_content("State: Coloarado")
      expect(page).to have_content("Zip code: 80906")
      expect(page).to have_content("Description: I like dogs. Give me a dog")
      espect(page).to have_content("Status: In Progress")
    end
  end
end