require 'rails_helper'

RSpec.describe 'the applications show page' do
  it "shows the application and all it's attributes" do
    application = Application.create!(name: "Holden Caulfield", street_address: "123 Main St", city: "New York", state: "NY", zipcode: "12345", description: "I wouldn't be a good pet owner", status: "Pending")
    # When I visit an applications show page
    visit "/applications/#{application.id}"
    # Then I can see the following:
# Name of the Applicant // Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content(application.pets)
    expect(page).to have_content(application.status)
  end

  xit 'includes a link to each pet page' do
    visit "/applications/#{application.id}"

    click_on("Hogan")
  end
end
