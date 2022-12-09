require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
  @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  describe 'the application new' do
    it 'displays link to start application' do
      visit '/pets' 
  
      expect(page).to have_content("Start an Application")
  
      click_on("Start an Application")
      expect(current_path).to eq('/applications/new')
    end

    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the application create' do
    it 'creates the application and redirects to the application show page' do
      visit "/applications/new"

      fill_in 'Name', with: 'Jeremy Mitchell'
      fill_in 'Address', with: '000 Main Street'
      fill_in 'City', with: 'San Francisco'
      fill_in 'State', with: 'California'
      fill_in 'Zip code', with: 94122 
      click_button 'Submit'
      new_app_id = Application.last.id

      expect(page).to have_current_path("/applications/#{new_app_id}")
      expect(page).to have_content('Jeremy')
    end
  end
end