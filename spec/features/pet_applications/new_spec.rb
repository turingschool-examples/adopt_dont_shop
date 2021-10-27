# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#
# Name
# Street Address
# City
# State
# Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'application new page' do
    it 'renders the form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      within('main') { expect(find('form')).to have_content('Name') }
      within('main') { expect(find('form')).to have_content('Street') }
      within('main') { expect(find('form')).to have_content('City') }
      within('main') { expect(find('form')).to have_content('State') }
      within('main') { expect(find('form')).to have_content('Zip') }
      within('main') { expect(find('form')).to have_content('Reason') }
    end
  end

  describe 'creation process' do
    context 'given valid data' do
      it 'creates the application and redirects' do
        visit '/applications/new'

        fill_in 'Name', with: 'Bob Smith'
        fill_in 'Street', with: '123 S Street'
        fill_in 'City', with: 'Mesa'
        fill_in 'State', with: 'AZ'
        fill_in 'Zip', with: '85025'
        fill_in 'Reason', with: 'Dog'

        click_button 'Submit'

        expect(page).to have_current_path("/applications/#{PetApplication.last.id}")
        expect(page).to have_content(PetApplication.last.name)
        expect(page).to have_content(PetApplication.last.street)
        expect(page).to have_content(PetApplication.last.city)
        expect(page).to have_content(PetApplication.last.state)
        expect(page).to have_content(PetApplication.last.zip)
        expect(page).to have_content(PetApplication.last.reason)
      end
    end
  end

  context 'given invalid data' do
    it 'gives an error and re-renders' do
      visit '/applications/new'

      click_button 'Submit'

      expect(page).to have_current_path('/applications/new')
      expect(page).to have_content('Error')
    end
  end
end
