require 'rails_helper'

RSpec.describe 'starting an application' do
  describe 'As a user when I visit the pet index page' do
    it 'I see a link to create a new application' do
      visit '/pets'

      expect(page). to have_link("Start an Application", href: "/applications/new" )
    end

    it 'brings me to a new submission from' do
      visit '/pets'

      click_link("Start an Application")

      expect(current_path).to eq('/applications/new')
    end

    it 'can create a new application and redirects to the application show page' do
      
      visit '/applications/new'

      fill_in('First Name', with: 'Jon')
      fill_in('Last Name', with: 'Duttko')
      fill_in('Street Address', with: '1018 O Street NW')
      fill_in('City', with: 'Washington')
      fill_in('State', with: 'DC')
      fill_in('Zip Code', with: '20001')
      click_button('Submit')

      expect(current_path).to eq("/applications/#{Application.last.id}")

      expect(page).to have_content("Jon")
      expect(page).to have_content("DC")
      expect(page).to have_content("In Progress")
    end
  end
end