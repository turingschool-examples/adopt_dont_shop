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
      applicant_1 = Applicant.create!(
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
      
      click_on 'Submit'
      
      expect(current_path).to eq("/applications/:id")
      expect(page).to have_content(applicant_1.name)
      expect(page).to have_content(applicant_1.full_address)
      expect(page).to have_content(applicant_1.description)
      expect(page).to have_content(applicant_1.status)
    end
  end
end