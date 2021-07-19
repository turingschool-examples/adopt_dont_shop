require 'rails_helper'

RSpec.describe 'create application' do
  describe 'the application creation' do
    it 'creates the application' do
      visit '/applications/new'

      fill_in 'Name', with: 'Taylor Hammond'
      fill_in 'Street address', with: '123 Street avenue'
      fill_in 'City', with: 'Dallas'
      fill_in 'State', with: 'Texas'
      fill_in 'Zip code', with: '98745'

      click_button 'Submit Application'

      expect(page).to have_content("Taylor Hammond")
    end

    it 'can display flash errors when left blank' do
      visit '/applications/new'

      fill_in 'Name', with: 'Taylor Hammond'
      fill_in 'Street address', with: '123 Street avenue'
      fill_in 'City', with: 'Dallas'
      fill_in 'State', with: 'Texas'
      fill_in 'Zip code', with: ''

      click_button 'Submit Application'

      expect(page).to have_content("Zip code can't be blank")
    end

    it 'can display flash errors for numericality' do
      visit '/applications/new'

      fill_in 'Name', with: 'Taylor Hammond'
      fill_in 'Street address', with: '123 Street avenue'
      fill_in 'City', with: 'Dallas'
      fill_in 'State', with: 'Texas'
      fill_in 'Zip code', with: 'dog'

      click_button 'Submit Application'

      expect(page).to have_content("Zip code is not a number")
    end
  end
end
