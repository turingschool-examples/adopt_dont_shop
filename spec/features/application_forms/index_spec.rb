require 'rails_helper'

RSpec.describe 'application show' do
  it 'displays the application form' do
#     Application Show Page
#
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  application = ApplicationForms.create!(name: "Joe Shmoe",
                                         street_address: '123 Commerce St',
                                         city: "Bridgeton",
                                         state: "NJ",
                                         zip_code: "08302",
                                         description: "I don't know",
                                         status: "IDK")
  visit "/application"
  expect(page).to have_content('Applicant')

  end
end
