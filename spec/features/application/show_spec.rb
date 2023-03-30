require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do application = Application.create!(
    :name "Billy Mays",
    :address  "123 Main street City State 10001"
    :description "I like pets"
    :
  )
end
  it 'shows hte name, address, description, pets, app status' do
    visit "/#{application.id}"

    expect(page).to have_content
  end
end

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"