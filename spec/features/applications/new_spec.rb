require 'rails_helper'

# User Story #? Then I am taken to the new application page where I see a form

RSpec.describe 'new application page' do
  def fill_in_fields_except_zipcode
    fill_in 'Name', with: 'My Application'
    fill_in 'Street Address', with: '123 Main Street'
    fill_in 'City', with: 'San Francisco'
    fill_in 'State', with: 'CA'
  end

  describe 'fields' do
    it 'has correct fields' do
      visit '/applications/new'
      expect(page).to have_field('Name')
      expect(page).to have_field('Street Address')
      expect(page).to have_field('City')
      expect(page).to have_field('State')
      expect(page).to have_field('Zip Code')
    end

    it 'saves the information' do
      visit '/applications/new'
      fill_in_fields_except_zipcode
      fill_in 'Zip Code', with: '94107'
      click_on 'Submit'

      expect(current_path).to_not eq '/applications/new'
      expect(page).to have_content('My Application')
      expect(page).to have_content('123 Main Street')
      expect(page).to have_content('San Francisco')
      expect(page).to have_content('CA')
      expect(page).to have_content('94107')
      expect(page).to have_content('In Progress')
    end
  end

  describe 'user story 3 (#5) visitor new app' do
    describe 'if a field is left blank #submit clicked' do
      it 'routes to app#new, and gives an error message' do
        visit '/applications/new'
        fill_in_fields_except_zipcode
        click_on 'Submit'

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content('Please provide a response for all fields.')
      end

      it 'will only accept a numerical zipcode' do
        visit '/applications/new'
        fill_in_fields_except_zipcode
        fill_in 'Zip Code', with: '94lol'

        click_on 'Submit'

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content('Please provide a response for all fields.')
      end
    end
  end
end
