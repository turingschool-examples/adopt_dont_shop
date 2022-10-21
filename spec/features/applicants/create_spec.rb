require 'rails_helper'

#2. Starting an Application
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
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
RSpec.describe  'application creation' do 
    it 'links from pet index page' do
      visit "/pets"

      click_link("Start Application")

      expect(current_path).to eq("/applicants/new")
    end

    it 'has a form to create an application once submitted redirects to applicants show page' do 
      visit "/applicants/new"

      fill_in "Name", with:"Judge Judy"
      fill_in "street_address", with:"666 Elm st"
      fill_in "city", with:"New Jersey"
      fill_in "state", with:"New Jersey"
      fill_in "zip", with:"8675309"
      fill_in "good_fit", with:"I am a Judgy Motha"


      click_button("Submit")
      applicant = Applicant.last
      expect(current_path).to eq("/applicants/#{applicant.id}")
      expect(page).to have_content("In Progress")
      
    end
end