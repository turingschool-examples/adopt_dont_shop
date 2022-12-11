require 'rails_helper'

RSpec.describe "New Application" do
  describe "link to new application with forms" do
    it 'has a link from pet index and has the forms required' do
      # As a visitor
      # When I visit the pet index page
      visit '/pets'
      # Then I see a link to "Start an Application"
      expect(page).to have_link("Start an Application")
      click_link("Start an Application")
      # When I click this link
      expect(current_path).to eq("/applications/new")
      # Then I am taken to the new application page where I see a form
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
      # When I fill in this form with my:
      # Name
      fill_in("Name", with: "Joe")
      # Street Address
      fill_in("Street address", with: "123 Apple St")
      # City
      fill_in("City", with: "Denver")
      # State
      fill_in("State", with: "CO")
      # Zip Code
      fill_in("Zip code", with: "80218")
      # And I click submit
      click_button("Submit")
      # Then I am taken to the new application's show page
      expect(current_path).to eq("/applications/#{Application.all.last.id}")
      # And I see my Name, address information, and description of why I would make a good home
      expect(page).to have_content("Joe")
      expect(page).to have_content("123 Apple St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Status: In Progress")
      # And I see an indicator that this application is "In Progress"
    end
  end

  describe "forms required to submit" do
    it "will redirect back to the forms page if not completely filled out" do
      # When I visit the new application page
      visit "/applications/new"
      # And I fail to fill in any of the form fields
      fill_in("Name", with: "Joe")
      fill_in("Street address", with: "123 Apple St")
      fill_in("City", with: "Denver")

      click_button("Submit")
      expect(current_path).to eq("/applications/new")
      # And I click submit
      # Then I am taken back to the new applications page
      # And I see a message that I must fill in those fields.
      expect(page).to have_content("Error")
    end
  end
end