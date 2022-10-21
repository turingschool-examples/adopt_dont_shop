# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

require 'rails_helper'

RSpec.describe 'New application page' do
  it 'links to the new page from the pet index' do
    visit '/pets'

    click_link 'Start an Application'
    expect(current_path).to eq('/applications/new')
  end
  it 'can create a new application' do
    visit '/applications/new'

    fill_in('Name', with: 'Mike Smith')
    fill_in(:street_address, with: '123 Test Street')
    fill_in(:city, with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in(:zipcode, with: 10005)
    fill_in(:description, with: "test description")

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")
  end

  it "takes the visitor back to the new application page if form fields are incomplete" do
    visit "/applications/new"

    fill_in('Name', with: 'Mike Smith')
    fill_in(:street_address, with: '123 Test Street')
    fill_in(:city, with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in(:description, with: "test description")
    click_button('Submit')

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Content missing #{Application.last.list_incomplete_fields}")
    #  save_and_open_page
  end
end
