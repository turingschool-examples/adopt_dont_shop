require 'rails_helper'

RSpec.describe "New Application" do
  describe "link to new application with forms" do
    it 'has a link from pet index and has the forms required' do
      # As a visitor
      # When I visit the pet index page
      visit '/pets'
      # Then I see a link to "Start an Application"
      has_link?("Start an Application")
      click_link("Start an Application")
      # When I click this link
      expect(current_path).to eq("/applications/new")
      # Then I am taken to the new application page where I see a form
      has_form?("Name")
      has_form?("Street Address")
      has_form?("City")
      has_form?("State")
      has_form?("Zip Code")
      has_form?("Description")
      has_form?("Pet Names")
      has_form?("Status")
      has_button?("Submit")
    end
  end

  describe "successful form creates application" do
    it 'accepts attributes and redirects with a new application' do
      visit "/applicaitons/new"
      # When I fill in this form with my:
      # Name
      fill_in("Name", with: "Joe")
      # Street Address
      fill_in("Street Address", with: "123 Apple St")
      # City
      fill_in("City", with: "Denver")
      # State
      fill_in("State", with: "CO")
      # Zip Code
      fill_in("Zip Code", with: "80218")
      fill_in("Description", with: "I like dogs")
      # And I click submit
      click_button("Submit")
      # Then I am taken to the new application's show page
      expect(current_path).to eq("/applications/#{Application.all.last}")
      # And I see my Name, address information, and description of why I would make a good home
      expect(page).to have_content("Joe")
      expect(page).to have_content("123 Apple St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Description:")
      expect(page).to have_content("Status: In Progress")
      # And I see an indicator that this application is "In Progress"
    end
  end
end