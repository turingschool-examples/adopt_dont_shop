

require 'rails_helper'

RSpec.describe 'the application show' do

  # [] done
  #
  # Application Show Page
  #
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  it "shows the application and all it's attributes" do
    application_one = Application.create!(name: 'Sally Mae', address: '123 West 23rd Ave Parker, CO 80134', description: 'Looking for a pet', status: "Pending" )
    visit "/applications/#{application_one.id}"

    expect(page).to have_content(application_one.name)
    expect(page).to have_content(application_one.address)
    expect(page).to have_content(application_one.description)
    expect(page).to have_content(application_one.status)
  end

end
