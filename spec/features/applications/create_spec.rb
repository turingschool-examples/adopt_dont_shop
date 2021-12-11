require 'rails_helper'

RSpec.describe 'application creation' do

  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Description')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application and redirects to the application show page' do
        visit "/applications/new"

        fill_in 'Name', with: 'Kelly'
        fill_in 'Address', with: '123 test st'
        fill_in 'City', with: 'Aurora'
        fill_in 'State', with: 'CO'
        fill_in 'Description', with: 'A description'
        click_button 'Save'
        expect(page).to have_current_path("/applications/")
        expect(page).to have_content('Kelly')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        click_button 'Save'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Address can't be blank")
      end
    end
  end
end
