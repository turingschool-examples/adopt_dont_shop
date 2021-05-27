require 'rails_helper'

RSpec.describe 'applications new page', type: :feature do

  describe '#new page appearance' do
    it 'contains the nav bar' do
      visit "/applications/new"

      expect(page).to have_content("Pets")
      expect(page).to have_content("Shelters")
      expect(page).to have_content("Home")
    end
    it 'has certain fields' do
      visit "/applications/new"

      expect(page).to have_content('Full Name')
      expect(page).to have_content('Street Address')
      expect(page).to have_content('City')
      expect(page).to have_content('State')
      expect(page).to have_content('Zip Code')
    end
  end
  describe '#new page functionality' do
    it 'allows you to enter info and redirects you to the applications#show page on submission' do

      visit "/applications/new"
      fill_in 'name', with: 'Big Bird'
      fill_in 'street_address', with: '1311 E 27TH AVE'
      fill_in 'city', with: 'DENVER'
      fill_in 'state', with: 'CO'
      fill_in 'zip_code', with: '80205'
      click_button 'Submit Applicant Details'
      last_app = Application.last

      expect(current_path).to eq("/applications/#{last_app.id}")
    end
    it 'flashes an error message and stays on the page if you fail to fill in any field' do

      visit "/applications/new"

      fill_in 'street_address', with: '1311 E 27TH AVE'
      fill_in 'city', with: 'DENVER'
      fill_in 'state', with: 'CO'
      fill_in 'zip_code', with: '80205'
      click_button 'Submit Applicant Details'
      last_app = Application.last

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Warning - You must fill in all fields before beginning your application!")
    end
  end
end
