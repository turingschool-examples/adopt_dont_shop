require 'rails_helper'

RSpec.describe 'applications/new', type: :feature do
  describe 'When I visit the applications new page' do
    it 'I can fill out an application' do
      visit '/applications/new'

      fill_in 'Name', with: 'Taylor'
      fill_in 'Address', with: '123 Side St'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80202'
      fill_in 'Description', with: 'I love animals'

      click_button 'Submit'

      expect(current_path).to eq("/applications/#{Application.last.id}")
    end
  end

end