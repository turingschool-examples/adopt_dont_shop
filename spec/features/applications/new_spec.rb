require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a new applications page' do
    it 'I can see application form data' do

      visit "/applications/new"

      expect(page).to have_content("Name")
      expect(page).to have_content("Street address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip code")
      expect(page).to have_content("Why you might be a good fit for adoption")
      expect(page).to have_content("Your application status is: In Progress")
    end
  end
end
