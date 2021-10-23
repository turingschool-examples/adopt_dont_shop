require 'rails_helper'

RSpec.describe 'new application page' do
  describe 'as a visitor' do
    describe 'when I visit the pet index page' do
      it 'can see a link to start an application' do
        visit "/pets"
        click_link('Start an Application')

        expect(current_path).to eq('/applications/new')
      end
    end

    describe 'i am taken to the new application page' do
      it 'i fill in the form' do
        application = create :application
        visit new_application_path

        fill_in :name, with: application.name
        fill_in :address, with: application.address
        fill_in :city, with: application.city
        fill_in :state, with: application.state
        fill_in :zip, with: application.zip
        click_button 'Submit'

        expect(current_path).to eq("/applications/#{Application.last.id}")

        expect(page).to have_content(application.name)
        expect(page).to have_content(application.address)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip)
      end

      describe 'i fill in the form incorrectly and am redirected back to new page' do
        it 'takes me back to the new applications page with a message' do
          visit new_application_path
          click_button 'Submit'
#Flash message
          expect(current_path).to eq(new_application_path)
        end
      end
    end
  end
end
