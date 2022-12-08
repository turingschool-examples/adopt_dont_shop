# As a visitor
# When I visit an applications show page
# Then I can see the following:

# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe Application, type: :feature do
  let!(:application) { Application.create!(
        human_name: "Brad Pitt",
        description: "Very rich, multiple homes, ample backyard space.",
        street_address: "123 Hollywood Blvd",
        city: "Los Angeles",
        state: "CA",
        zip: "90210",
        status: "Rejected")}
  let!(:application_2) { Application.create!(
        human_name: "Aziz Ansari",
        description: "Very funny, entertaining to dogs",
        street_address: "777 Lucky Street",
        city: "Seattle",
        state: "WA",
        zip: "98101",
        status: "Pending")}

  describe 'application show page' do
    it 'displays the attributes of a single application' do
      visit "/applications/#{application.id}"
      save_and_open_page
      expect(page).to have_content(application.human_name)
      expect(page).to have_content("123 Hollywood Blvd")
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip)
      expect(page).to have_content(application.status)

      visit "/applications/#{application_2.id}"

      expect(page).to have_content(application_2.human_name)
      expect(page).to have_content("777 Lucky Street")
      expect(page).to have_content(application_2.description)
      expect(page).to have_content(application_2.city)
      expect(page).to have_content(application_2.state)
      expect(page).to have_content(application_2.zip)
      expect(page).to have_content(application_2.status)
    end
  end
end