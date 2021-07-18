require 'rails_helper'

RSpec.describe 'application' do
  before(:each) do
    @application = Application.create(name: 'Jason Knoll',
                                      street_address: '1234 N. Something St',
                                      city: "Scottsdale",
                                      state: "AZ",
                                      zip_code: "99999",
                                      description: "I love pets",
                                      status: "In Progress")
  end

  it 'shows specifications of certain applicant' do
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    #
    # Name of the Applicant
    # Full Address of the Applicant including street address, city, state, and zip code
    # Description of why the applicant says they'd be a good home for this pet(s)
    # names of all pets that this application is for (all names of pets should be links to their show page)
    # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    visit "applications/#{@applicaiton.id}"

    expect(page).to have_content(@applicaiton.name)
    expect(page).to have_content(@applicaiton.street_address)
    expect(page).to have_content(@applicaiton.city)
    expect(page).to have_content(@applicaiton.state)
    expect(page).to have_content(@applicaiton.zip_code)
    expect(page).to have_content(@applicaiton.description)
    expect(page).to have_content(@applicaiton.status)
  end
end
