require 'rails_helper'


RSpec.describe 'the applications index' do
#   As a visitor
# When I visit an applications show page
# Then I can see the following:
#
# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  it 'displays the applicant attributes ' do
    applicant = Application.create!(name: 'Chris',
                                    address: '505 Main St.',
                                    city: 'Denver',
                                    state: 'CO',
                                    zipcode: '80205',
                                    description: "I'm great with dogs.",
                                    status: 'In-progress')
    visit "/applications/#{applicant.id}"
    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zipcode)
    expect(page).to have_content(applicant.description)
    expect(page).to have_content(applicant.status)
  end
end
