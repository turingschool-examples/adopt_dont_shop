require 'rails_helper'

RSpec.describe "when I visit the pet index page", type: :feature do
  describe "I see a link to 'Start an application'" do
    it "links me to a form to create a new application" do
      visit "/pets"
      click_on "Start an Application"
      expect(current_page).to eq("/applications/new")
    end

    it "let's me fill out an application" do
      visit "/applications/new"

      fill_in("same", with: "Celeste Chere")
      fill_in("street_address", with: "123 Easy St")
      fill_in("city", with: "Narshe")
      fill_in("zip_code", with: 00234)
      click_button "Submit"

      expect(current_page).to eq("/applications/#{application.id}")
      expect(page).to have_content("Celeste Chere")
      expect(page).to have_content("123 Easy St")
      expect(page).to have_content("Narshe")
      expect(page).to have_content(00234)
    end
  end
end
