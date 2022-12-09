
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe 'the application show' do
  it 'shows the applicant attributes' do
    application = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks")

    visit "/applications/#{application.id}"
    # save_and_open_page
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
  end

  it "Shows why the applicant says they'd be a good home for this pet(s)" do
    application = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks")

    visit "/applications/#{application.id}"
    expect(page).to have_content(application.description)
  end
end