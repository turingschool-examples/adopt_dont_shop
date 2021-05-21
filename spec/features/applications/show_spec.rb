require 'rails_helper'

RSpec.describe 'applications show page', type: :feature do
  before (:each) do
    @application1 = Application.create(
      name: "Big Bird",
      street_address: "1311 E 27TH AVE",
      city: "DENVER",
      state: "CO",
      zip_code: 80205,
      statement: nil
    )
  end

  describe '#show page appearance' do

    it 'has certain fields' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Application Status: In Progress')
      expect(page).to have_content('Name:')
      expect(page).to have_content('Big Bird')
      expect(page).to have_content('Street Address:')
      expect(page).to have_content('1311 E 27TH AVE')
      expect(page).to have_content('City:')
      expect(page).to have_content('DENVER')
      expect(page).to have_content('State:')
      expect(page).to have_content('CO')
      expect(page).to have_content('Zip Code:')
      expect(page).to have_content('80205')
      expect(page).to have_content('Why you think you would be a good pet parent:')
    end
  end
end