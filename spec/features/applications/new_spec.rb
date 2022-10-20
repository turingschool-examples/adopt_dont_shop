require 'rails_helper'

RSpec.describe 'application creation', type: :feature do
  describe 'creating an application' do
    it 'links to the new page from the pets index' do
      visit '/pets'

      click_link('New Application')
      expect(current_path).to eq('/applications/new')
    end

    it 'can create a new application' do
      visit '/applications/new'
  
      fill_in('Name', with: 'Frank Ocean')
      fill_in('Street', with: '44 Thinkin Bout You Rd')
      fill_in('City', with: 'Denver')
      select('Colorado', from: :state)
      fill_in('Zipcode', with: '12345')
      fill_in('Description', with: 'Need a sibling for my other dog')
      
      click_button 'Create Application'

      new_app = Application.last

      expect(current_path).to eq("/applications/#{new_app.id}")
      expect(page).to have_content(new_app.name)
      expect(page).to have_content(new_app.street_address)
      expect(page).to have_content(new_app.city)
      expect(page).to have_content(new_app.state)
      expect(page).to have_content(new_app.zipcode)
      expect(page).to have_content(new_app.description)
      expect(page).to have_content(new_app.status)
    end
  end
end