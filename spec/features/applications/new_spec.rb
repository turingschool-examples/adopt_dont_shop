require 'rails_helper'

RSpec.describe "when I visit the pet index page", type: :feature do
  describe "I see a link to 'Start an application'" do
    it "links me to a form to create a new application" do
      visit "/pets"
      click_on "Start an Application"
      expect(current_page).to eq("/applications/new")
    end
  end
end
