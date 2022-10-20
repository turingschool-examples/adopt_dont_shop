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
  describe "As a visitor" do
    describe "When I visit an applications show" do
      it "Then I can see the applications attributes" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")

        ApplicationPet.create!(pet: becky, application: application)

        visit "/applications/#{application.id}"
        # save_and_open_page
        expect(page).to have_content("Bob Smith")
        expect(page).to have_content("1234 Easy St.")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content(80001)
        expect(page).to have_content("temp description")
        expect(page).to have_content("In Progress")
        expect(page).to have_link("Becky")

        click_link "Becky"

        expect(current_path).to eq("/pets/#{becky.id}")
      end
    end
  end
end
