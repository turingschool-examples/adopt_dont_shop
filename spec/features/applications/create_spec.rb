require 'rails_helper'

RSpec.describe 'application creation' do
   it 'renders the new form' do
            visit '/applications/new'

            expect(page).to have_content('New Application')
            expect(find('form')).to have_content('Name')
            expect(find('form')).to have_content('Street')
            expect(find('form')).to have_content('City')
            expect(find('form')).to have_content('State')
            expect(find('form')).to have_content('Zip code')
        end

   it "creates a new application" do
      visit '/applications/new'

      fill_in 'name', with: 'Big Bird'
      fill_in 'address_street', with: '123 Sesame St.'
      fill_in 'address_city', with: 'New York'
      fill_in 'address_state', with: 'NY'
      fill_in 'address_zip_code', with: '10001'
      click_button 'Submit'

      application = Application.last

      expect(page).to have_current_path("/applications/#{application.id}")
      expect(page).to have_content('Big Bird')
      expect(page).to have_content('123 Sesame St.')
      expect(page).to have_content('New York')
      expect(page).to have_content('NY')
      expect(page).to have_content('10001')
      expect(page).to have_content('Description Needed')
      expect(page).to have_content('In Progress')
   end

   it "has requried fields" do 
     visit '/applications/new'

     click_button 'Submit'

     expect(current_path).to eq('/applications/new')
     expect(page).to have_content("Please fill all fields")
   end
end
