# [ ] done

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe "Application Show Page" do
  describe "User Story 1" do
    describe "User visits '/applicants/:id'" do
      it 'has applicant attributes' do
        visit "/applicants/#{@applicant.id}"

        expect(page).to have_content(@applicant.name)
        expect(page).to have_content(@applicant.address)
        expect(page).to have_content(@applicant.description)
        expect(page).to have_content(@applicant.pets)
        expect(page).to have_content(@applicant.status)
      end
    end
  end
end