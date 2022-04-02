require 'rails_helper'

RSpec.describe "when I visit the pet index page", type: :feature do
  describe "I see a link to 'Start an application'" do
    it "links me to a form to create a new application" do
      visit "/pets"
      click_on "Start an Application"
      expect(current_path).to eq("/applications/new")
    end

    it "let's me fill out an application" do
      visit "/applications/new"

      fill_in("name", with: "Celeste Chere")
      fill_in("street", with: "123 Easy St")
      fill_in("city", with: "Narshe")
      fill_in("state", with: "CO")
      fill_in("zip", with: 00234)
      click_button "Submit"

      expect(page).to have_content("Celeste Chere")
      expect(page).to have_content("123 Easy St")
      expect(page).to have_content("Narshe")
      expect(page).to have_content(00234)
      expect(page).to have_content("In Progress")

    end

    it 'sends user back to form if all the fields are not filled in' do
      visit "/applications/new"

      fill_in("name", with: "Celeste Chere")
      fill_in("street", with: "123 Easy St")
      fill_in("zip", with: 00234)
      click_button "Submit"
      expect(current_path).to eq('/applications/new')
      expect(page).to have_content("Please fill out all fields!")
    end
  end
end
