require 'rails_helper'

RSpec.describe "New Application" do
  describe "link to new application with forms" do
    it 'has a link from pet index and has the forms required' do
      visit '/pets'

      expect(page).to have_link("Start an Application")
      click_link("Start an Application")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_field("Name")
      expect(page).to have_field("Street address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip code")
      expect(page).to have_button("Submit")
    end
  end

  describe "successful form creates application" do
    it 'accepts attributes and redirects with a new application' do
      visit "/applications/new"
      fill_in("Name", with: "Joe")
      fill_in("Street address", with: "123 Apple St")
      fill_in("City", with: "Denver")
      fill_in("State", with: "CO")
      fill_in("Zip code", with: "80218")

      click_button("Submit")

      expect(current_path).to eq("/applications/#{Application.all.last.id}")
      expect(page).to have_content("Joe")
      expect(page).to have_content("123 Apple St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Status: In Progress")
    end
  end


  describe "errors" do
    let!(:invalid_application) {build_stubbed(:application, zip_code: "Denver")}

    it "will redirect back to the forms page if not completely filled out" do
      visit "/applications/new"
      fill_in("Name", with: invalid_application.name)
      fill_in("Street address", with: invalid_application.street_address)
      fill_in("City", with: invalid_application.city)
      click_button("Submit")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error")
    end
    
    it "form filled out with invalid data" do
      visit "/applications/new"
      
      fill_in("Name", with: invalid_application.name)
      fill_in("Street address", with: invalid_application.street_address)
      fill_in("City", with: invalid_application.city)
      fill_in("State", with: invalid_application.state)
      fill_in("Zip code", with: invalid_application.zip_code)
      
      click_button("Submit")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error")
    end
  end

end