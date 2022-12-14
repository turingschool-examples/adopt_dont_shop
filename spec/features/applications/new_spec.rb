require 'rails_helper'

RSpec.describe 'new application' do

  describe 'User Story 2' do
    it 'can fill out a form' do
      visit '/applications/new'  

      fill_in('Name', with: 'Bob')
      fill_in('Street Address', with: '123 Lead Street')
      fill_in('City', with: 'Denver')
      fill_in('State', with: 'CO')
      fill_in('Zip Code', with: '80020')
      
      click_on 'Submit'

      application = Application.last

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.full_address)
      expect(page).to have_content(application.status)
    end
  end

  describe "User Story 3" do
    describe "User fails to fill in form field" do
      it "redirects back to new application page with error message" do
        visit '/applications/new' 

        fill_in('Name', with: 'Bob')
        fill_in('Street Address', with: '123 Lead Street')
        fill_in('City', with: 'Denver')
        fill_in('State', with: 'CO')
          
        click_on 'Submit'

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Zip code can't be blank")
      end
    end
  end
end