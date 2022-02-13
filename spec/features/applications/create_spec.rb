require 'rails_helper'
RSpec.describe 'application creation' do

  describe 'new application' do
    it 'renders the new app form' do
      visit '/pets'

      expect(page).to have_link('Start an Application')
      click_link('Start an Application')
      expect(page).to have_current_path('/applications/new')

      expect(find('form')).to have_content("First name")
      expect(find('form')).to have_content('Last name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('Post code')

    end
  end


  describe 'new application' do
    it 'creates the application' do
      visit '/applications/new'

      fill_in 'First name', with: 'Sammy'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Street address', with: '367 CBTIS Overton St.'
      fill_in 'City', with: 'Washington DC'
      fill_in 'Post code', with: 12647

      click_button 'Submit Application'
      sammy = Application.last

      expect(page).to have_current_path("/applications/#{sammy.id}")
      expect(page).to have_content('Sammy')
      expect(page).to have_content('In Progress')
    end
  end

  context 'given incomplete data' do
    it 're-renders the new form' do
      visit '/applications/new'

      fill_in 'First name', with: 'Sammy'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Street address', with: '367 CBTIS Overton St.'

      click_button 'Submit Application'

      expect(page).to have_current_path('/applications/new')
      expect(page).to have_content("Error: City can't be blank, Post code can't be blank")
    end
  end

end
