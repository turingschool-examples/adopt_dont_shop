require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip Code')

    end
  end

  describe 'the application create' do
    it 'creates the application and redirects to the shelter applications index' do
      visit "/applications/new"

      fill_in 'Name', with: 'Sean Morris'
      fill_in 'Street Address', with: '4950 Hooker St.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip Code', with: '80201'

      click_button 'Submit Application'
      # expect(page).to have_current_path("/applications/#{@application.id}")
      expect(page).to have_content('Sean Morris')
      expect(page).to have_content('4950 Hooker St.')
      expect(page).to have_content('Denver')
      expect(page).to have_content('In Progress')
    end
  end

#I might need to specify which field is missing
#I might need to go back to the page where previous user inputs still exist
  describe 'the application create' do
    it 'give an error message if name or address is missing' do
      visit "/applications/new"

      fill_in 'Name', with: 'Sean Morris'
      fill_in 'Street Address', with: '4950 Hooker St.'
      fill_in 'State', with: 'CO'
      fill_in 'Zip Code', with: '80201'

      click_button 'Submit Application'
      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content('fill out ALL application fields')
    end
  end
end
