require 'rails_helper'

RSpec.describe 'the application create' do
  it 'can create a new application' do

    visit "pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '90210'

    click_button "Submit"
    save_and_open_page
    expect(page).to have_content('Jimbo Jones')
    expect(page).to have_content('123 Fake St Denver CO 90210')
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