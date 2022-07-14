require 'rails_helper'

RSpec.describe 'the application new page' do
  it "has a link on the pet index to make an application" do
    visit "/pets"

    click_on('Start an Application')

    expect(current_path).to eq('/applications/new')
  end

  it 'the new page has a form to collect info to create a new application' do
    visit '/applications/new'

    fill_in('name', with: 'new person')
    fill_in('street_address', with: '456 pickup st')
    fill_in('city', with: 'Bridgeport')
    fill_in('state', with: 'CT')
    fill_in('zipcode', with: '12345')

    click_on('Submit')
    application = Application.last

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content('new person')
    expect(page).to have_content('456 pickup st')
    expect(page).to have_content('Bridgeport')
    expect(page).to have_content('CT')
    expect(page).to have_content('12345')
    expect(page).to have_content('Description Needed')
    expect(page).to have_content('In Progress')
   end
end
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