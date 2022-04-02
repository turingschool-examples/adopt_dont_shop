require 'rails_helper'

RSpec.describe 'application creation' do
  # before(:each) do
  #   @application = Application.create!(name: "Marky Mark", street_address: "678 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")
  # end

  describe 'the new application' do
    it 'renders the new application form' do
      visit "/applications/new"

      expect(page).to have_content("New Application:")
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Status')
      expect(find('form')).to have_button('Submit')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application and redirects to the applications show' do

        visit "/applications/new"
        fill_in 'Name', with: "Silly Name"
        fill_in 'Street address', with: "133 L St."
        fill_in 'City', with: "Richmond"
        fill_in 'State', with: "VA"
        fill_in 'Zip code', with: "23229"
        click_button 'Submit'

        expect(page).to have_content("Application For:")
        expect(page).to have_content("Silly Name")
        expect(page).to have_content("133 L St.")
        expect(page).to have_content("Richmond")
        expect(page).to have_content("VA")
        expect(page).to have_content("23229")
        expect(page).to have_content("In progress")
      end
    end
    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"
        click_button 'Submit'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Zip code is not a number")
      end
    end
  end
end
