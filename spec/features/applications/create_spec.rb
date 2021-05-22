require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application' do
        visit '/applications/new'

        fill_in 'Name', with: 'Chris P. Bacon'
        fill_in 'Street address', with: '123 Main Street'
        fill_in 'City', with: 'Anytown'
        fill_in 'State', with: 'CO'
        fill_in 'Zip code', with: 12345

        click_button 'Save'

        expect(page).to have_content('Chris P. Bacon')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
        click_button 'Save'

        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Zip code is not a number")
        expect(page).to have_current_path('/applications/new')
      end
    end
  end
end