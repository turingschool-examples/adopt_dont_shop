require 'rails_helper'

RSpec.describe 'new application' do
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

  describe 'User Story 2' do
    it 'can fill out a form' do
      application_1 = Application.create!(
        name: "Bob",
        street_address: "123 Leaf Street",
        city: "Denver",
        state: "CO",
        zip_code: 80020,
        description: "Work from home",
        status: "In Progress"
      )

      visit '/applications/new'      
      fill_in('Name', with: 'Bob')
      fill_in('Street address', with: '123 Lead Street')
      fill_in('City', with: 'Denver')
      fill_in('State', with: 'CO')
      fill_in('Zip code', with: '80020')
      fill_in('Description', with: 'I work from home and need a friend')
      
      click_on 'Submit'
      application_2 = Application.last

      expect(current_path).to eq("/applications/#{application_2.id}")
      expect(page).to have_content(application_2.name)
      expect(page).to have_content(application_2.full_address)
      expect(page).to have_content(application_2.description)
      expect(page).to have_content(application_2.status)
    end
  end
end