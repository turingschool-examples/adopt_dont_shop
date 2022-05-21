require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip')
      expect(find('form')).to have_content('Description')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application and redirects to the show page' do
        visit "/applications/new"

        fill_in 'Name', with: 'Professor T'
        fill_in 'Street', with: '123 Road Street'
        fill_in 'City', with: 'Metropolis'
        fill_in 'State', with: 'NC'
        fill_in 'Zip', with: 12345
        fill_in 'Description', with: "I like this dog."
        click_button 'Submit'
        application_id = Application.last.id
        expect(page).to have_current_path("/applications/#{application_id}")
        expect(page).to have_content('Professor T')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        click_button 'Save'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Address can't be blank, Zip is not a number")
      end
    end
  end
end
