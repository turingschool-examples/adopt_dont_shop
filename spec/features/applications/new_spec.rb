require 'rails_helper'

RSpec.describe 'Start a new application' do
  describe "has a form and ability to create a new application" do
    it 'has form and saves application' do
      application_1 = Application.create!(name: 'Antonio', street_address: '1234 Drury Lane', city: 'San Francisco', state: 'CA', zip_code: '94016', description: 'God', status: 0)
        visit '/applications/new'
        fill_in :name, with: "Archie"
        fill_in :street_address, with: "44 Aloha Ave"
        fill_in :city, with: "Bubble T"
        fill_in :state, with: "GA"
        fill_in :zip_code, with: "66666"
        fill_in :description, with: "I am a good mother!"
        click_button 'Submit'
        expect(page).to have_content('Archie')
        expect(page).to have_content('44 Aloha Ave')
        expect(page).to have_content('Bubble T')
        expect(page).to have_content('GA')
        expect(page).to have_content('66666')
        expect(page).to have_content('I am a good mother!')
        expect(page).to_not have_content('Antonio')
      end
    end

    describe 'all new application form fields must be filled out' do
      it 'displays error message and redirects to new app page' do
        visit '/applications/new'
        fill_in :name, with: "Archie"
        fill_in :street_address, with: "44 Aloha Ave"
        fill_in :state, with: "GA"
        fill_in :zip_code, with: "66666"
        click_button 'Submit'

        expect(page).to have_content("Application not created: Required information missing")
        expect(current_path).to eq('/applications/new')
      end
    end

end
