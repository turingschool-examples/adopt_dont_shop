require 'rails_helper'

RSpec.describe Application do
  describe '#new' do
    it 'can create a new application' do
      visit '/pets'
      click_link 'Fill out an application'
      fill_in('Name', with: 'John')
      fill_in('Street address', with: '1234 Clarkson ln.')
      fill_in('City', with: 'Denver')
      fill_in('State', with: 'Colorado')
      fill_in('Zip code', with: '80003')
      click_button('Submit')

      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content('John')
      expect(page).to have_content('1234 Clarkson ln.')
      expect(page).to have_content('Denver')
      expect(page).to have_content('Colorado')
      expect(page).to have_content('80003')
      expect(page).to have_content('In Progress')
    end
  end
end