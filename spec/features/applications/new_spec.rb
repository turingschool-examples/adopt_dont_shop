require 'rails_helper'

RSpec.describe 'application new page', type: :feature do
  describe 'As a visitor' do

    it 'I expect to see a form to fill out with 8 fields' do
      visit "/application/new"

      expect(page).to have_content("First Name:")
      expect(page).to have_content("Last Name:")
      expect(page).to have_content("Address:")
      expect(page).to have_content("City:")
      expect(page).to have_content("State:")
      expect(page).to have_content("Zip Code:")
      expect(page).to have_content("Description")
      expect(page).to have_content("Status:")

    end

    xit 'If I do not fill out a field & click submit I am taking to the new app page & I see a message that I must fill in those fields' do
      visit "/application/new"

      fill_in('First Name:', with: "Penny")
      fill_in('Last Name:', with: "Smith")
      fill_in('Address:', with: "182 Stuart Street" )
      fill_in('City:', with: 'Baton Rouge')
      fill_in('State:', with: 'CO')
      fill_in('Zip Code:', with: 10243)
      fill_in('Description', with: "I would really like this animal, please please!")

      click_on('Apply for Pet')
      
      expect(current_path).to eq("/application/new")
      expect(page).to have_content("You must fill in the missing information before proceeding.")
    end

  
  end
end
