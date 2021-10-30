require "rails_helper"

RSpec.describe "application index page", type: :feature do
  describe "start application" do
    it "has a link to start an application " do
      visit "/applications"
      click_on "Start an Application"

      expect(current_path).to eq("/applications/new")

      fill_in :name, with: "Haewon Jeon"
      fill_in :street_address, with: "4950 Hooker St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip_code, with: "80525"

      click_on "Submit Application"
      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content("Haewon Jeon")
      expect(page).to have_content("Denver")
      expect(page).to have_content("In Progress")
    end

    it "gives error message if form is not complete" do
      visit "/applications"
      click_on "Start an Application"

      fill_in :name, with: "Haewon Jeon"
      fill_in :street_address, with: "4950 Hooker St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"

      click_on "Submit Application"
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error")
    end
  end
end
