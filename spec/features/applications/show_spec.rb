require 'rails_helper'
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
RSpec.describe 'Application show page' do
  before do
    @app_1 = Application.create!(name: 'bob', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: 'Joe, Champ, Pixie', status: 2)

    visit "/applications/#{@app_1.id}"
  end

  it 'Then I can see application attributes' do

    expect(page).to have_content("#{@app_1.name}")
    expect(page).to have_content("#{@app_1.address}")
    expect(page).to have_content("#{@app_1.description}")
    expect(page).to have_content("#{@app_1.pet_names}")
    expect(page).to have_content("#{@app_1.status}")
  end
end