require "rails_helper"

RSpec.describe "pet adoption application creation", type: :feature do
  describe "new application" do
    it "has Start an Application link on pet index page" do
      visit "/pets"
      click_link "Start an Application"

      expect(page).to have_current_path("/applications/new")
    end
  end

  describe "the new adoption application form" do
    it "renders the new adoption form" do
      visit "/applications/new"

      expect(page).to have_content("Pet Adoption Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street Address")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip Code")
    end
  end

  describe "the new adoption application create form" do
    it "creates the new adoption application form and redirects to the new adoption application show page" do
      visit "/applications/new"

      fill_in "Name", with: "John Smith"
      fill_in "Street Address", with: "321 Main St"
      fill_in "City", with: "Littleton"
      fill_in "State", with: "CO"
      fill_in "Zip Code", with: 80333
      click_button "Submit"

      application = Application.last
      save_and_open_page
      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("John Smith")
      expect(page).to have_content("In Progress")
    end
  end
end
