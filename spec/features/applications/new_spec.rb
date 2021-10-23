require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  describe 'the application new' do
    it 'renders the new form' do
      visit "/pets/"

      click_link('Start an Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application and redirects to the application show page' do
        visit "/applications/new"

        fill_in 'Name', with: 'John Lennon'
        fill_in 'Street address', with: '4500 Lenox Street'
        fill_in 'City', with: 'New York City'
        fill_in 'State', with: 'New York'
        fill_in 'Zip', with: '80631'
        click_button 'Submit'
        expect(page).to have_current_path("/applications/#{Application.last.id}")

        expect(page).to have_content('John Lennon')
        expect(page).to have_content('4500 Lenox Street, New York City, New York, 80631')
        expect(page).to have_content('In Progress')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        click_button 'Submit'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip can't be blank")
      end
    end
  end
end
