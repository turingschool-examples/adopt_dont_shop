require 'rails_helper'

# Then I am taken to the new application page where I see a form
# When I fill in this form with my:

# Name
# Street Address
# City
# State
# Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

RSpec.describe 'new application page' do
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
      fill_in 'Name', with: 'My Application'
      fill_in 'Street Address', with: '123 Main Street'
      fill_in 'City', with: 'San Francisco'
      fill_in 'State', with: 'CA'
      fill_in 'Zip Code', with: '94107'
      fill_in 'Description', with: 'I luv dawgs'

      click_on 'Submit'

      expect(current_path).to_not eq '/applications/new'
      expect(page).to have_content('My Application')
      expect(page).to have_content('123 Main Street')
      expect(page).to have_content('San Francisco')
      expect(page).to have_content('CA')
      expect(page).to have_content('94107')
      expect(page).to have_content('I luv dawgs')
      expect(page).to have_content('In Progress')
    end
  end

  describe 'user story 3 (#5) visitor new app' do
    describe 'if a field is left blank #submit clicked' do
      it 'routes to app#new, and gives an error message' do
        visit '/applications/new'
        fill_in 'Name', with: 'My Application'
        fill_in 'Street Address', with: '123 Main Street'
        fill_in 'City', with: 'San Francisco'

        click_on 'Submit'

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content('Please provide a response for all fields.')
      end

      it 'will only accept a numerical zipcode' do
        visit '/applications/new'
        fill_in 'Name', with: 'My Application'
        fill_in 'Street Address', with: '123 Main Street'
        fill_in 'City', with: 'San Francisco'
        fill_in 'State', with: 'CA'
        fill_in 'Zip Code', with: '94lol'
        fill_in 'Description', with: 'I luv dawgs'

        click_on 'Submit'

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content('Please provide a response for all fields.')
      end
    end
  end
end
