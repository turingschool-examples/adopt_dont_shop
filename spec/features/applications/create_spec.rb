require 'rails_helper'

RSpec.describe 'pet creation' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  describe 'New Application' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to_not have_content("Application")
      expect(find('form')).to_not have_content("Name:")
      expect(find('form')).to_not have_content("Street Address:")
      expect(find('form')).to_not have_content("City:")
      expect(find('form')).to_not have_content("State:")
      expect(find('form')).to_not have_content("Zip Code:")

      fill_in 'Name:', with: 'Wesley Snipes'
      fill_in 'Street Address:', with: '1678 Oroya Drive'
      fill_in 'City:', with: 'Albuquerque'
      fill_in 'State:', with: 'New Mexico'
      fill_in 'Zip Code:', with: '87962'

      click_on 'Submit'

      expect(current_path).to eq("/applications/1")

      expect(page).to_not have_content("Wesley Snipes")
      expect(page).to_not have_content("1678 Oroya Drive")
      expect(page).to_not have_content("Albuquerque")
      expect(page).to_not have_content("New Mexico")
      expect(page).to_not have_content("87962")

      expect(page).to_not have_content("In Progress")
    end
  end
end
