require 'rails_helper'

RSpec.describe "Owner applications Show Page", type: :feature do
  before(:each) do
    @application1 = OwnerApplication.create!(name: 'Wyatt Wicks', street_address: '559 s. washington st', city: 'Denver', state: 'Colorado', zip_code: 80209, description: "sample", status: "In Progress")
  end
  describe "As a visitor" do
    describe "When I visit an applications show page" do
      it "shows info of an application" do
        visit "/applications/#{@application1.id}"
        expect(page).to have_content(@application1.name)
        expect(page).to have_content(@application1.street_address)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.state)
        expect(page).to have_content(@application1.zip_code)
        expect(page).to have_content(@application1.description)
        expect(page).to have_content(@application1.status)

        # Uncomment line below when relationship to pets is complete
        # expect(page).to have_content(@application1.pets)
      end
      describe "then the application has not been submitted" do
        it "I see a section on the page to add a pet" do
          visit "/applications/#{@application1.id}"
          expect(page).to have_content("Search for Pets by Name")
          fill_in "Search for Pets by Name", with: "josie"
          click_button "Submit"
          expect(current_path).to be("/applications/#{@application1.id}")
          expect(page).to have_content("Josie")
        end
      end
    end
  end
end
# Searching for Pets for an Application
#
# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
