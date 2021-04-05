require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit an applications show page' do
    it 'can show an application with attributes' do
      application = Application.create!(
        name: "Bob Ham",
        street_address: "5714 Carmel Rd",
        city: "Charlotte",
        state: "NC",
        zipcode: 28226,
        description: "eh breddy gool guy",
        status: "In Progress"
      )

      visit "/applications/#{application.id}"

      expect(page).to have_content("Bob Ham")
      expect(page).to have_content("5714 Carmel Rd")
      expect(page).to have_content("Charlotte")
      expect(page).to have_content("NC")
      expect(page).to have_content("28226")
      expect(page).to have_content("eh breddy gool guy")
      expect(page).to have_content("In Progress")
    end
  end
end
