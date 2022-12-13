require 'rails_helper'

RSpec.describe 'new application' do

# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.

  describe 'User Story 2' do
    it 'can fill out a form' do
      application_1 = Application.create!(
        name: "Bob",
        street_address: "123 Leaf Street",
        city: "Denver",
        state: "CO",
        zip_code: 80020
      )

      visit '/applications/new'    
      fill_in('Name', with: 'Bob')
      fill_in('Street Address', with: '123 Lead Street')
      fill_in('City', with: 'Denver')
      fill_in('State', with: 'CO')
      fill_in('Zip Code', with: '80020')
      
      click_on 'Submit'
      application_2 = Application.last

      expect(current_path).to eq("/applications/#{application_2.id}")
      expect(page).to have_content(application_2.name)
      expect(page).to have_content(application_2.full_address)
      expect(page).to have_content(application_2.status)
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