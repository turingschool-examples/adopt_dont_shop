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
    
    # 3.Starting an Application, Form not Completed
    # As a visitor
    # When I visit the new application page
    # And I fail to fill in any of the form fields
    # And I click submit
    # Then I am taken back to the new applications page
    # And I see a message that I must fill in those fields.

    describe 'given invalid data' do
      it 're-renders the new form' do
        visit "/applicants/new"

        click_button 'Submit'
        expect(page).to have_current_path("/applicants/new")
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip can't be blank, Good fit can't be blank")
     
      end
    end 
end