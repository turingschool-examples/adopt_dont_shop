require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application' do
        application = Application.create!(name: "Suzie Kim", street_address: "123 State Street", 
                                      city: "Boston", state: "Massachusetts", zip_code: 02115, 
                                      description: "I am patient and ready.")
        visit '/applications/new'

        fill_in 'Name', with: 'Suzie Kim'
        fill_in 'Street Address', with: "123 State Street"
        fill_in 'City', with: 'Boston'
        fill_in 'State', with: 'Massachusetts'
        fill_in 'Zip code', with: 02115
        fill_in "Why are you a good home?", with: "I am patient and ready."
       
        click_button 'Submit'
        save_and_open_page
        expect(page).to have_current_path("/applications/#{application.id}")
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
       
        fill_in 'City', with: 'Houston'
        click_button 'Submit'

        expect(page).to have_current_path('/applications/new')
        expect(page).to have_content("Error: Name can't be blank, Street Address can't be blank, State can't be blank, Zip Code is not a number, Why are you a good home? can't be blank")
      end
    end
  end
end
