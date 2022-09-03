require 'rails_helper'

RSpec.describe 'the application creation' do

  describe 'the pet new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_content('Description')
    end
  end
end

describe 'the application create' do
  context 'given valid data' do
    it 'creates the application and redirects to the application show page' do
      visit "/applications/new"

      fill_in 'Name', with: "Carter Ball"
      fill_in 'Street address', with: "123 Easy Street"
      fill_in 'City', with: "Atlanta"
      fill_in 'State', with: "GA"
      fill_in 'Zipcode', with: 30307
      fill_in 'Description', with: "I want a pet"

      expect { click_on "Submit" }.to change { Application.count }.by(1)

      app = Application.last

      expect(page).to have_current_path("/applications/#{app.id}")
      expect(page).to have_content('Carter Ball')
    end

    context 'given incomplete data in the form' do
      it 'redirects user to new applications page with instructions to fill in empty fields' do
        visit "/applications/new"

        click_button 'Submit'

        expect(current_path).to eq("/applications")
        expect(page).to have_content("Error: Name can't be blank")
        expect(page).to have_content("Error: Street address can't be blank")
        expect(page).to have_content("Error: City can't be blank")
        expect(page).to have_content("Error: State can't be blank")
        expect(page).to have_content("Error: Zip code can't be blank")
        expect(page).to have_content("Error: Description can't be blank")
      end
    end
  end
end

