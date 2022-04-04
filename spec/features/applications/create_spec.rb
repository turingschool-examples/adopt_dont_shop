require 'rails_helper'

RSpec.describe 'application creation' do
  
  describe 'the new application' do
    it 'there is a form with fields' do
      visit "/applications/new" 
      
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_button('Submit')
    end
    
    it "can be filled in with info and creates a new app" do
      visit "/applications/new" 
      fill_in 'Name', with: 'Joe Blow'
      fill_in 'Address', with: '3242 W 12st'
      fill_in 'City', with: 'Castle Rock'
      fill_in 'State', with: 'CO'
      fill_in 'Zipcode', with: '1254'
      click_on 'Submit'
      application = Application.last
      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content('Joe Blow')
      expect(page).to have_content('In progress')      
    end
    it "will return error message if inccorectly filled out" do
      visit "/applications/new" 
      fill_in 'Name', with: 'Joe Blow'
      fill_in 'City', with: 'Castle Rock'
      fill_in 'State', with: 'CO'
      fill_in 'Zipcode', with: '1254'
      click_on 'Submit'
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content('Error, please fill out form')      
    end
  end
end 
