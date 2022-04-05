require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'application new' do
    it 'renders the new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_content('Description')
    end
  end

  describe 'application creations' do
    context 'given valid data' do
      it 'creates the applications' do
        visit '/applications/new'

        fill_in 'Name', with: 'New Applicant'
        fill_in 'Address', with: '123 Street'
        fill_in 'City', with: 'CityVille'
        fill_in 'State', with: 'CO'
        fill_in 'Zipcode', with: '88888'
        fill_in 'Description', with: 'Text text text text text'

        click_button 'Save'
        @application = Application.find_by(name: 'New Applicant')
        expect(page).to have_current_path("/applications/#{@application.id}")
        expect(page).to have_content('Status: In Progress')
      end
    end

    context 'given invalid data' do
      it 'returns visitor to new application if form fields left empty' do
        visit '/applications/new'
        fill_in 'State', with: 'CO'

        click_button 'Save'

        expect(page).to have_current_path('/applications/new')
        expect(page).to have_content("Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank")
      end
    end
  end
end
