require 'rails_helper'

RSpec.describe 'the Applicant show' do
  before(:each) do
    app = Applicant.create(name: 'Test', street: "123", city:"fake", state: "fake", zip: 48248)

    visit "/applicants/#{app.id}"
  end
# Story 1
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  it 'has the attributes of the applicant' do

    expect(page).to have_content(app.name)
    expect(page).to have_content(app.street)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zip)
  end
end